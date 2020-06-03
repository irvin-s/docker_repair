FROM gliderlabs/alpine:3.4
MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL Name="librarian_packer_aws" Vendor="sortuniq" Version="0.0.3" \
      Description="run Makefiles and librarian-puppet to packerise for aws"
# build instructions:
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

ARG PACKER_VERSION

ENV APP="packer"                    \
    VERSION=$PACKER_VERSION         \
    ASSETS_DIR="assets"             \
    ASSETS_DOCKER="/var/tmp/assets" \
    SCRIPTS_DOCKER="/var/tmp/assets/build-scripts-alpine"

COPY $ASSETS_DIR $ASSETS_DOCKER

RUN chmod a+x $SCRIPTS_DOCKER/*                          \
    && $SCRIPTS_DOCKER/install_librarian_and_puppet.sh   \
    && $SCRIPTS_DOCKER/install_packer.sh                 \
    && $SCRIPTS_DOCKER/install_awscli.sh                 \
    && apk --no-cache --update add coreutils jq make sed \
    && rm -rf /var/cache/apk/* $ASSETS_DOCKER 2>/dev/null
  
CMD ["/bin/true"]
