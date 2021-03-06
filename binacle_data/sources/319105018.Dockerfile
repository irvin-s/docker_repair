# This Dockerfile builds an image containing the Mac version of the installer layered
# on top of the Linux installer image.

FROM registry.svc.ci.openshift.org/ocp/builder:golang-1.10 AS builder
WORKDIR /go/src/github.com/openshift/installer
COPY . .
RUN go generate ./data && \
    SKIP_GENERATION=y GOOS=darwin GOARCH=amd64 hack/build.sh

FROM registry.svc.ci.openshift.org/ocp/4.1:installer
COPY --from=builder /go/src/github.com/openshift/installer/bin/openshift-install /usr/share/openshift/mac/openshift-install
