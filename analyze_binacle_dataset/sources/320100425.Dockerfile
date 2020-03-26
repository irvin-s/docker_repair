# vim: et smartindent sr sw=4 ts=4:
# ... uses CMD | ENTRYPOINT FROM official nginx:stable-alpine, without daemon.
FROM nginx:stable-alpine
MAINTAINER Jinal Shah <jnshah@gmail.com>
LABEL Name="eil-content/nginx"  Vendor="sortuniq"  \
      Version="0.0.3"                              \
      com.eurostar.build_time=""                   \
      com.eurostar.built_by=""                     \
      com.eurostar.built_from=""                   \
      Description="Eurostar content product nginx, curl, vim, bespoke conf"

ENV ASSETS_DIR="assets" \
    ASSETS_DOCKER="/var/tmp/assets"

COPY $ASSETS_DIR $ASSETS_DOCKER

RUN apk --no-cache --update add curl vim \
  && cp -R $ASSETS_DOCKER/conf/* /       \
  && rm -rf /var/cache/apk/* $ASSETS_DOCKER 2>/dev/null

#
# build instructions:
# # ... build and tag as stable
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# # ... then after running and passing tests ...
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable
#
# run instructions:
# - designed to run as fpm proxy, mounting same content as php/drupal fpm container.
# - should live on same --net as php/drupal fpm container
#
# e.g. project lives in ~/app/srv
#
# docker run          \
#   --name nginx      \
#   --net app         \
#   -d                \
#   -p 0.0.0.0:80:80  \
#   -v ~/app/srv:/srv \
#   eil-content-nginx:stable
#
