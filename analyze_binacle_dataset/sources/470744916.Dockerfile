# This Dockerfile is used for building admission-controller on https://connect.redhat.com
FROM openshift/origin-release:golang-1.11 as builder
RUN yum update -y

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR /go/src/github.com/containers-ai/alameda

COPY . .

# Build
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags \"-X github.com/containers-ai/alameda/cmd/app.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'github.com/containers-ai/alameda/cmd/app.BUILD_TIME=`date`' -X 'github.com/containers-ai/alameda/cmd/app.GO_VERSION=`go version`'\" -a -o ./bin/admission-controller  github.com/containers-ai/alameda/admission-controller/cmd"]

# Copy the admission-controller into a thin image
FROM registry.access.redhat.com/ubi7/ubi-minimal
ENV SUMMARY="Alameda Admission Controller is used to update pod resource with recommandtion."	\
    DESCRIPTION="Alameda Admission Controller is used to update pod resource with recommandtion." \
    NAME="Alameda Admission Controller" \
    VERSION="latest" \
    USER_UID=1001 \
    USER_NAME=alameda

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="$NAME" \
      com.redhat.component="customer-container" \
      name="$NAME" \
      version="$VERSION" \
      vendor="ProphetStor Data Services, Inc."

COPY --from=builder /go/src/github.com/containers-ai/alameda/LICENSE /licenses/
COPY --from=builder /go/src/github.com/containers-ai/alameda/admission-controller/etc/admission-controller.yml /etc/alameda/admission-controller/admission-controller.yml
COPY --from=builder /go/src/github.com/containers-ai/alameda/bin/admission-controller /usr/local/bin/
EXPOSE 8000/tcp

RUN chown -R 1001:0 /etc/alameda && mkdir -p /var/log/alameda && chown -R 1001:0 /var/log/alameda && chmod ug+w /var/log/alameda

USER 1001
ENTRYPOINT ["/usr/local/bin/admission-controller", "run"]
