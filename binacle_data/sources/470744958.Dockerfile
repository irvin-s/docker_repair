# This Dockerfile is used for building alameda-datahub on https://connect.redhat.com
FROM openshift/origin-release:golang-1.11 as builder
RUN yum update -y

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR /go/src/github.com/containers-ai/alameda

COPY . .

# Build
RUN ["/bin/bash", "-c", "go build -ldflags \"-X main.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'main.BUILD_TIME=`date`' -X 'main.GO_VERSION=`go version`'\" -a -o ./datahub/datahub github.com/containers-ai/alameda/datahub/cmd"]

# Copy the alameda-datahub into a thin image
FROM registry.access.redhat.com/ubi7/ubi-minimal
ENV SUMMARY="Alameda Datahub is an API gateway for handling gRPC requests."	\
    DESCRIPTION="Alameda Datahub is an API gateway for handling gRPC requests." \
    NAME="Alameda Datahub" \
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
COPY --from=builder /go/src/github.com/containers-ai/alameda/datahub/etc/datahub.yml /etc/alameda/datahub/datahub.yml
COPY --from=builder /go/src/github.com/containers-ai/alameda/datahub/datahub /usr/local/bin/
EXPOSE 50050/tcp

RUN chown -R 1001:0 /etc/alameda && mkdir -p /var/log/alameda && chown -R 1001:0 /var/log/alameda && chmod ug+w /var/log/alameda

USER 1001
ENTRYPOINT ["/usr/local/bin/datahub", "run"]
