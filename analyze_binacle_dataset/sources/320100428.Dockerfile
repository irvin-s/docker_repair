FROM dev_basic:stable
MAINTAINER Jinal Shah <jnshah@gmail.com>
LABEL Name="env_devbox" Vendor="sortuniq" Version="0.0.1" \
      Description="tools to hack terraform and packer for building envs"
# build instructions:
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

ARG TERRAFORM_VERSION
ARG PACKER_VERSION

ENV TERRAFORM_VERSION=$TERRAFORM_VERSION \
    PACKER_VERSION=$PACKER_VERSION \
    HASHI_SCRIPT=hashicorp_tools_setup.sh

COPY $HASHI_SCRIPT /var/tmp/$HASHI_SCRIPT
RUN /usr/bin/env bash /var/tmp/$HASHI_SCRIPT
  
CMD ["/bin/true"]
