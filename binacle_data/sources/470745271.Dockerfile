# This Dockerfile is used for building alameda-datahub on https://connect.redhat.com
FROM registry.access.redhat.com/devtools/go-toolset-1.10-rhel7:1.10.3-15 as builder
USER root
# Copy in the go src
WORKDIR /opt/app-root/src/go/src/github.com/containers-ai/alameda
ADD . .

# Build
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags \"-X main.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'main.BUILD_TIME=`date`' -X 'main.GO_VERSION=`go version`'\" -a -o ./operator/manager github.com/containers-ai/alameda/operator/cmd/manager"]

# Copy the controller-manager into a thin image
FROM registry.access.redhat.com/rhscl/s2i-core-rhel7:1-51
ENV SUMMARY="Alameda Controller (code name: Karina) 0.2 is a controller for reconciling Alameda scaling configuration CRD."	\
    DESCRIPTION="Alameda Controller (code name: Karina) 0.2 is a controller for reconciling Alameda scaling configuration CRD." \
    NAME="Karina (Alameda controller)" \
    VERSION="0.2"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="$NAME" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
      io.s2i.scripts-url=image:///usr/libexec/s2i \
      com.redhat.component="customer-container" \
      name="$NAME" \
      version="$VERSION" \
      vendor="Federator AI"

WORKDIR /opt/app-root/src
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/LICENSE /licenses/
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/operator/etc/operator.yml /etc/alameda/operator/operator.yml
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/operator/manager .
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/operator/config/crds /etc/alameda/operator/crds
EXPOSE 50050/tcp 50443/tcp

RUN chown -R 1001:0 /etc/alameda/operator/ && chown -R 1001:0 ./
USER 1001
ENTRYPOINT ["./manager"]
