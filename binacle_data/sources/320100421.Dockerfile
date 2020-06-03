FROM gliderlabs/alpine:3.4
MAINTAINER Jinal Shah <jnshah@gmail.com>
LABEL Name="dev_basic" Description="basic workspace process" Vendor="sortuniq" Version="0.0.7"
# build instructions:
# # ... build and tag as stable
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

ARG VIM_INDENT=4
ENV VIM_INDENT=$VIM_INDENT             \
    ASSETS_DIR="assets"                \
    ASSETS_DOCKER="/var/tmp/assets"    \
    ASSETS_HOME="/var/tmp/assets/home" \
    SCRIPTS_DOCKER="/var/tmp/assets/build-scripts-alpine" \
    PKGS="bash coreutils curl docker git grep less make openssh sed tree"

COPY $ASSETS_DIR $ASSETS_DOCKER
RUN  chmod a+x $SCRIPTS_DOCKER/*                         \
  && apk add --no-cache --update $PKGS                   \
  && /usr/bin/env sh $SCRIPTS_DOCKER/install_vim.sh      \
  && /usr/bin/env sh $SCRIPTS_DOCKER/create_user_core.sh \
  && cp -R $ASSETS_HOME/. /home/core                     \
  && cp -R $ASSETS_HOME/. /root                          \
  && chown -R core:core /home/core                       \
  && chown -R root:root /root                            \
  && rm -rf $ASSETS_DOCKER

CMD ["/bin/bash"]
