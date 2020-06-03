#
# A Dockerfile for generating an image quick&fast from a local build
#

FROM opensuse/leap:15.0

ARG BUILD_DIR="/go/src/github.com/kubic-project/dex-operator"
ARG BUILT_EXE="cmd/dex-operator/dex-operator"

COPY $BUILT_EXE /usr/local/bin/dex-operator
RUN  chmod 755 /usr/local/bin/dex-operator

CMD ["/usr/local/bin/dex-operator"]
