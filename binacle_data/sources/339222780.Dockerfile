FROM scratch

MAINTAINER Black Duck OpsSight Team

ARG LASTCOMMIT
ARG BUILDTIME
ARG VERSION

# Container catalog requirements
COPY ./LICENSE /licenses/
COPY ./help.1 /help.1

COPY ./opssight-core ./opssight-core

LABEL name="Black Duck OpsSight Core" \
      vendor="Black Duck Software" \
      release.version="$VERSION" \
      summary="Black Duck OpsSight Core" \
      description="This container is used to get image and pod informations from opsight-image-processor and opssight-pod-processor in Kubernetes and Red Hat OpenShift clusters. It will send received images to the Black Duck scanner for scanning. It will also periodically retrieves vulnerability and policy violations from the Black Duck Hub and makes them available to opssight-image-processor and opssight-pod-processor." \
      lastcommit="$LASTCOMMIT" \
      buildtime="$BUILDTIME" \
      license="apache" \
      release="$VERSION" \
      version="$VERSION"

CMD ["./opssight-core"]
