FROM goreleaser/goreleaser

RUN go get -d github.com/apptio/kubeadm-bootstrap && \
    cd ${GOPATH}/src/github.com/apptio/kubeadm-bootstrap && \
    CGO_ENABLED=0 go install
RUN /go/bin/kubeadm-bootstrap --help

FROM scratch
WORKDIR /
COPY --from=0 /go/bin/kubeadm-bootstrap ./kubeadm-bootstrap
ENTRYPOINT ["/kubeadm-bootstrap", "--dry-run", "--quiet"]

