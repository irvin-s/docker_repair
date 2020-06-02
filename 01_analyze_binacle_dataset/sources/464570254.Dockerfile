FROM photon:2.0 as builder
MAINTAINER Venil Noronha <veniln@vmware.com>

RUN tdnf --refresh install -y wget tar gzip git && \
    wget -P /tmp -q https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf /tmp/go1.12.1.linux-amd64.tar.gz && \
    mkdir -p /root/go/src /root/go/bin
ENV GOPATH=/root/go
ENV GOBIN=/root/go/bin
ENV GO111MODULE=on
WORKDIR /root/go/src/github.com/vmware/wavefront-adapter-for-istio/
COPY ./ .
RUN CGO_ENABLED=0 GOOS=linux /usr/local/go/bin/go build -a -installsuffix cgo -v -o bin/wavefront ./wavefront/cmd/

FROM photon:2.0
RUN tdnf install -y openssl-1.0.2o-3.ph2.x86_64
WORKDIR /bin/
COPY --from=builder /root/go/src/github.com/vmware/wavefront-adapter-for-istio/bin/wavefront .
COPY open_source_licenses .
ENTRYPOINT [ "/bin/wavefront" ]
CMD [ "8000" ]
EXPOSE 8000
