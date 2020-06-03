# This Dockerfile is used for building alameda-datahub on local-okd
FROM registry.access.redhat.com/devtools/go-toolset-1.10-rhel7:1.10.3-15 as builder
USER root
# Copy in the go src
WORKDIR /opt/app-root/src/go/src/github.com/containers-ai/alameda
ADD . .

# Build
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags \"-X github.com/containers-ai/alameda/cmd/app.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'github.com/containers-ai/alameda/cmd/app.BUILD_TIME=`date`' -X 'github.com/containers-ai/alameda/cmd/app.GO_VERSION=`go version`'\" -a -o ./bin/admission-controller  github.com/containers-ai/alameda/admission-controller/cmd"]

FROM registry.access.redhat.com/rhscl/s2i-core-rhel7:1-51
ENV SUMMARY="Alameda Admission Controller is used to update pod resource with recommandtion."	\
    DESCRIPTION="Alameda Admission Controller is used to update pod resource with recommandtion." \
    NAME="Alameda Admission Controller" \
    VERSION="0.2.5"

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

COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/bin/admission-controller .
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/admission-controller/etc/admission-controller.yml /etc/alameda/admission-controller/admission-controller.yml
EXPOSE 8000/tcp

RUN chown -R 1001:0 /etc/alameda/admission-controller/ && chown -R 1001:0 ./
USER 1001
ENTRYPOINT ["./admission-controller", "run"]
