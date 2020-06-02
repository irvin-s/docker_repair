FROM scratch

MAINTAINER Black Duck OpsSight Team

ARG LASTCOMMIT
ARG BUILDTIME
ARG VERSION

# Container catalog requirements
COPY ./LICENSE /licenses/
COPY ./help.1 /help.1

COPY ./opssight-pod-processor ./opssight-pod-processor

LABEL name="Black Duck OpsSight Pod Processor" \
      vendor="Black Duck Software" \
      release.version="$VERSION" \
      summary="Black Duck OpsSight Pod Processor" \
      description="Identifies all images inside each pod in a Kubernetes or Red Hat OpenShift cluster. It will send all the identified images to opssight-core for scanning. It will also retrieve vulnerability and policy violations for each image periodically from opssight-core and annotate and label each pod with the information for each image." \
      lastcommit="$LASTCOMMIT" \
      buildtime="$BUILDTIME" \
      license="apache" \
      release="$VERSION" \
      version="$VERSION"

CMD ["./opssight-pod-processor"]
