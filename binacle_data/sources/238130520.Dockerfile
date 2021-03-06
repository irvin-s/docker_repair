FROM golang:1.9.3 as builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        rsync \
    && rm -rf /var/lib/apt/lists/*

ENV KUBE_VERSION v1.10.2
ADD https://storage.googleapis.com/kubernetes-release/release/$KUBE_VERSION/bin/linux/amd64/kubectl /usr/bin/kubectl
RUN chmod +x /usr/bin/kubectl

RUN git clone --depth 50 --branch $KUBE_VERSION \
    https://github.com/kubernetes/kubernetes.git /go/src/k8s.io/kubernetes

WORKDIR /go/src/k8s.io/kubernetes

# minimal needed for tests
RUN make ginkgo
RUN make WHAT='test/e2e/e2e.test'

FROM debian
MAINTAINER Mikkel Oscar Lyderik Larsen <m@moscar.net>

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /go/src/k8s.io/kubernetes/_output/bin/e2e.test /e2e.test
COPY --from=builder /go/src/k8s.io/kubernetes/_output/bin/ginkgo /usr/bin/ginkgo
COPY --from=builder /usr/bin/kubectl /usr/bin/kubectl

ENV KUBECTL_PATH /usr/bin/kubectl
ENV KUBECONFIG /kubeconfig

ENTRYPOINT ["/usr/bin/ginkgo"]
