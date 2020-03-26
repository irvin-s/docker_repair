FROM gcr.io/google_containers/kube-cross:v1.6.2-1

ARG GOARCH=arm
ARG CC=arm-linux-gnueabi-gcc

ENV GOARM=6 \
	CGO_ENABLED=0 \
	OUTPUT_DIR=/build/bin \
	REGISTRY_DIR=${GOPATH}/src/github.com/docker/distribution \
	HEAPSTER_DIR=${GOPATH}/src/k8s.io/heapster \
	INFLUXDB_DIR=${GOPATH}/src/github.com/influxdb/influxdb \
	GRAFANA_DIR=${GOPATH}/src/github.com/grafana/grafana \
	GRAFANA_ROOTFS_DIR=/tmp/grafana \
	CONTRIB_DIR=${GOPATH}/src/k8s.io/contrib \
	HELM_DIR=${GOPATH}/src/k8s.io/helm

ENV REGISTRY_VERSION=v2.5.0 \
	HEAPSTER_VERSION=v1.2.0-beta.2 \
	INFLUXDB_VERSION=v0.13.0 \
	GRAFANA_VERSION=v3.1.1 \
	GRAFANA_DL_VERSION=3.1.1-1470047149 \
	CONTRIB_COMMIT=c694368aadb0e9d7d5710ea6d76ee9d10756580c \
	INGRESS_CONTROLLER_VERSION=0.8.3 \
	HELM_VERSION=v2.0.0-alpha.3

RUN mkdir -p \
	${OUTPUT_DIR} \
	${REGISTRY_DIR} \
	${HEAPSTER_DIR} \
	${INFLUXDB_DIR} \
	${GRAFANA_DIR} \
	${CONTRIB_DIR} \
	${HELM_DIR}

RUN curl -sSL https://github.com/docker/distribution/archive/${REGISTRY_VERSION}.tar.gz | tar -xz -C ${REGISTRY_DIR} --strip-components=1 \
	&& cd ${REGISTRY_DIR} \
	&& go build -a --installsuffix cgo --ldflags "-X `go list ./version`.Version=${REGISTRY_VERSION}" -o bin/registry ./cmd/registry \
	&& cp bin/registry ${OUTPUT_DIR}

RUN curl -sSL https://github.com/kubernetes/heapster/archive/${HEAPSTER_VERSION}.tar.gz | tar -C ${HEAPSTER_DIR} -xz --strip-components=1 \
	&& cd ${HEAPSTER_DIR} \
	&& go build -a --installsuffix cgo -o heapster k8s.io/heapster/metrics \
	&& go build -a --installsuffix cgo -o eventer k8s.io/heapster/events \
	&& cp heapster eventer ${OUTPUT_DIR}

RUN curl -sSL https://github.com/influxdata/influxdb/archive/${INFLUXDB_VERSION}.tar.gz | tar -C ${INFLUXDB_DIR} -xz --strip-components=1 \
	&& cd ${INFLUXDB_DIR} \
	&& GOARCH=amd64 go get github.com/sparrc/gdm \
	&& gdm restore \
	&& ln -s $GOPATH/src/github.com/influxdb/influxdb $GOPATH/src/github.com/influxdata/ \
	&& go build -a --installsuffix cgo --ldflags="-s" -o influxd ./cmd/influxd \
	&& cp influxd ${OUTPUT_DIR} \
	&& GOARCH=amd64 go build -a --installsuffix cgo --ldflags="-s" -o influxd ./cmd/influxd \
	&& ./influxd config > ${OUTPUT_DIR}/influxdb.toml \
	&& sed -i 's/dir = "\/.*influxdb/dir = "\/data/' ${OUTPUT_DIR}/influxdb.toml

RUN curl -sSL https://github.com/grafana/grafana/archive/${GRAFANA_VERSION}.tar.gz | tar -C ${GRAFANA_DIR} -xz --strip-components=1 \
	&& cd ${GRAFANA_DIR} \
	&& GOARCH=amd64 CGO_ENABLED=1 CC=gcc go run build.go setup \
	&& godep restore \
	&& CGO_ENABLED=1 go build --ldflags="-w -X main.version=${GRAFANA_VERSION} -X main.commit=unknown-dev -X main.timestamp=0 -extldflags '-static'" -o grafana-server ./pkg/cmd/grafana-server \
	&& CGO_ENABLED=1 go build --ldflags="-w -X main.version=${GRAFANA_VERSION} -X main.commit=unknown-dev -X main.timestamp=0 -extldflags '-static'" -o grafana-cli ./pkg/cmd/grafana-cli \
	&& cp grafana-server grafana-cli ${OUTPUT_DIR}

RUN curl -sSL https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_DL_VERSION}_amd64.deb > /tmp/grafana.deb \
	&& dpkg -x /tmp/grafana.deb ${GRAFANA_ROOTFS_DIR} \
	&& cp -f ${GRAFANA_DIR}/grafana-server ${GRAFANA_DIR}/grafana-cli ${GRAFANA_ROOTFS_DIR}/usr/sbin/ \
	&& curl -sSL https://raw.githubusercontent.com/kubernetes/heapster/${HEAPSTER_VERSION}/grafana/dashboards/pods.json > ${OUTPUT_DIR}/pods.json \
	&& curl -sSL https://raw.githubusercontent.com/kubernetes/heapster/${HEAPSTER_VERSION}/grafana/dashboards/cluster.json > ${OUTPUT_DIR}/cluster.json \
	&& cd ${GRAFANA_ROOTFS_DIR} && tar -cf ${OUTPUT_DIR}/grafana.tar .

RUN git clone https://github.com/kubernetes/contrib ${CONTRIB_DIR} \
	&& cd ${CONTRIB_DIR} && git checkout ${CONTRIB_COMMIT} \
	&& cd ${CONTRIB_DIR}/service-loadbalancer \
	&& godep go build -a --installsuffix cgo -ldflags '-w' -o service_loadbalancer ./service_loadbalancer.go ./loadbalancer_log.go \
	&& cp service_loadbalancer ${OUTPUT_DIR} \
	&& cd ${CONTRIB_DIR}/scale-demo/aggregator \
    && make aggregator \
    && cp aggregator ${OUTPUT_DIR} \
	&& cd ${CONTRIB_DIR}/scale-demo/vegeta \
    && CGO_ENABLED=0 GOOS=linux godep go build -a -installsuffix cgo -ldflags '-w' -o loader \
    && cp loader ${OUTPUT_DIR} \
	&& cd ${CONTRIB_DIR}/ingress/controllers/nginx \
    && CGO_ENABLED=0 GOOS=linux godep go build -a -installsuffix cgo -ldflags "-w -X main.version=${INGRESS_CONTROLLER_VERSION} -X main.gitRepo=git@github.com:kubernetes/contrib" -o nginx-ingress-controller \
    && cp nginx-ingress-controller ${OUTPUT_DIR}

RUN curl -sSL https://github.com/kubernetes/helm/archive/${HELM_VERSION}.tar.gz | tar -xz -C ${HELM_DIR} --strip-components=1 \
	&& cd ${HELM_DIR} \
	&& GOARCH=amd64 make bootstrap \
	&& go build -a -installsuffix cgo -ldflags '-w' -o helm ./cmd/helm \
	&& go build -a -installsuffix cgo -ldflags '-w' -o tiller ./cmd/tiller \
	&& cp helm tiller ${OUTPUT_DIR}
