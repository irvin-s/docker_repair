FROM centos:centos7

MAINTAINER Black Duck OpsSight Team

ARG LASTCOMMIT
ARG BUILDTIME
ARG VERSION

# Container catalog requirements
COPY ./LICENSE /licenses/
COPY ./help.1 /help.1

COPY ./opssight-scanner ./opssight-scanner

LABEL name="Black Duck OpsSight Scanner" \
      vendor="Black Duck Software" \
      release.version="$VERSION" \
      summary="Black Duck OpsSight Scanner" \
      description="This container is used to scan images received from opsight-core." \
      lastcommit="$LASTCOMMIT" \
      buildtime="$BUILDTIME" \
      license="apache" \
      release="$VERSION" \
      version="$VERSION"

CMD ["./opssight-scanner"]
