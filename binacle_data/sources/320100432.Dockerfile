# vim: ts=4 sw=4 et sr smartindent syntax=dockerfile:
FROM dev_basic:stable
MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL Name="dev_librarian_packer_aws" Vendor="sortuniq" Version="0.0.3" \
      Description="                 \
                Devbox for running: \
                Makefiles           \
                librarian-puppet    \
                packer              \
                terraform           \
                awscli              \
                credstash           "
# build instructions:
# img_name=$(grep '^LABEL ' ./Dockerfile.dev | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile.dev | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build -f ./Dockerfile.dev --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

ARG PACKER_VERSION

ENV ASSETS_DIR="assets"                  \
    ASSETS_DOCKER="/var/tmp/assets"      \
    PKGS="coreutils jq make sed gettext" \
    SCRIPTS_DOCKER="/var/tmp/assets/build-scripts-alpine"

COPY $ASSETS_DIR $ASSETS_DOCKER

USER root
RUN chmod a+x $SCRIPTS_DOCKER/*                        \
    && apk --no-cache --update add $PKGS               \
    && $SCRIPTS_DOCKER/install_librarian_and_puppet.sh \
    && $SCRIPTS_DOCKER/install_packer.sh               \
    && $SCRIPTS_DOCKER/install_terraform.sh            \
    && $SCRIPTS_DOCKER/install_awscli.sh               \
    && $SCRIPTS_DOCKER/install_credstash.sh            \
    && $SCRIPTS_DOCKER/install_docker.sh               \
    && rm -rf /var/cache/apk/* $ASSETS_DOCKER 2>/dev/null
  
USER core
CMD ["/bin/true"]
