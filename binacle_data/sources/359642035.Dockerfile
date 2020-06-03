FROM gcr.io/google_containers/kube-cross:v1.6.2-1

ARG GOARCH=arm
ARG CC=arm-linux-gnueabi-gcc

ENV GOARM=6 \
    ETCD_DIR=${GOPATH}/src/github.com/coreos/etcd \
    FLANNEL_DIR=${GOPATH}/src/github.com/coreos/flannel \
    K8S_DIR=${GOPATH}/src/k8s.io/kubernetes \
    OUT_DIR=/output \
    ETCD_VERSION=v2.2.5 \
    FLANNEL_VERSION=v0.5.5 \
    K8S_VERSION=v1.3.0 \
    KUBE_BUILD_PLATFORMS="linux/arm"


# Make directories
RUN mkdir -p \
    ${OUT_DIR} \
    ${ETCD_DIR} \
    ${FLANNEL_DIR} \
    ${K8S_DIR}

RUN GOARCH=amd64 go get github.com/tools/godep

RUN curl -sSL https://github.com/coreos/etcd/archive/${ETCD_VERSION}.tar.gz | tar -C ${ETCD_DIR} -xz --strip-components=1 \
    && cd ${ETCD_DIR} \
    && ./build \
    && cp bin/* ${OUT_DIR}

RUN curl -sSL https://github.com/coreos/flannel/archive/${FLANNEL_VERSION}.tar.gz | tar -C ${FLANNEL_DIR} -xz --strip-components=1 \
    && cd ${FLANNEL_DIR}  \
    && CGO_ENABLED=1 ./build \
    && cp bin/* ${OUT_DIR}

RUN curl -sSL https://github.com/kubernetes/kubernetes/archive/${K8S_VERSION}.tar.gz | tar -C ${K8S_DIR} -xz --strip-components=1 \
    && cd ${K8S_DIR} \
    && CGO_ENABLED=1 ./hack/build-go.sh cmd/hyperkube cmd/kubectl test/e2e/e2e.test test/e2e_node/e2e_node.test \
    && cp _output/local/go/bin/linux_${GOARCH}/* ${OUT_DIR} \
    && rm ${OUT_DIR}/teststale
