# This Dockerfile is used for building alameda-datahub on local-okd
FROM registry.access.redhat.com/devtools/go-toolset-1.10-rhel7:1.10.3-15 as builder
USER root
# Copy in the go src
WORKDIR /opt/app-root/src/go/src/github.com/containers-ai/alameda
ADD . .

# Build
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags \"-X main.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'main.BUILD_TIME=`date`' -X 'main.GO_VERSION=`go version`'\" -a -o ./evictioner/evictioner github.com/containers-ai/alameda/evictioner/cmd"]

FROM registry.access.redhat.com/rhscl/s2i-core-rhel7:1-51
ENV SUMMARY="Alameda Evictioner is used to update pod resource with recommandtion."	\
    DESCRIPTION="Alameda Evictioner is used to update pod resource with recommandtion." \
    NAME="Alameda Evictioner" \
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
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/evictioner/etc/evictioner.yml /etc/alameda/evictioner/evictioner.yml
COPY --from=builder /opt/app-root/src/go/src/github.com/containers-ai/alameda/evictioner/evictioner .

RUN chown -R 1001:0 /etc/alameda/evictioner/ && chown -R 1001:0 ./
USER 1001
ENTRYPOINT ["./evictioner"]
CMD [ "run" ]
