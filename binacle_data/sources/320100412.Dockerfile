FROM gliderlabs/alpine:3.4
MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL Name="awscli" Vendor="sortuniq" Version="0.0.2" \
      Description="provides awscli - entrypoint 'aws'"
# build instructions:
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

ENV ASSETS_DIR="assets"             \
    ASSETS_DOCKER="/var/tmp/assets" \
    SCRIPTS_DOCKER="/var/tmp/assets/build-scripts-alpine"

COPY $ASSETS_DIR $ASSETS_DOCKER

RUN chmod a+x $SCRIPTS_DOCKER/*                        \
    && $SCRIPTS_DOCKER/install_awscli.sh               \
    && apk --no-cache --update add sed                 \
    && rm -rf /var/cache/apk/* $ASSETS_DOCKER 2>/dev/null
  
CMD ["aws"]
ENTRYPOINT ["aws"]
