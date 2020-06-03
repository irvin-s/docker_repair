FROM scratch

MAINTAINER Black Duck OpsSight Team

ARG LASTCOMMIT
ARG BUILDTIME
ARG VERSION

# Container catalog requirements
COPY ./LICENSE /licenses/
COPY ./help.1 /help.1

COPY ./opssight-image-processor ./opssight-image-processor

LABEL name="Black Duck OpsSight Image Processor" \
      vendor="Black Duck Software" \
      release.version="$VERSION" \
      summary="Black Duck OpsSight Image Processor" \
      description="This container is used to identify all images in a Red Hat OpenShift cluster. It will send all the identified images to opssight-core for scanning. It will also retrieve vulnerability and policy violations for each image periodically from opssight-core and annotate and label the image with the information." \
      lastcommit="$LASTCOMMIT" \
      buildtime="$BUILDTIME" \
      license="apache" \
      release="$VERSION" \
      version="$VERSION"

CMD ["./opssight-image-processor"]
