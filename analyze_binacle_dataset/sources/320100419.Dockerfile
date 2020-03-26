FROM gliderlabs/alpine:3.4
MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL Name="credstash" Vendor="sortuniq" Version="0.0.1" \
      Description="provides credstash wrapper for kms    \
      - entrypoint 'credstash'                           \
      - See https://github.com/fugue/credstash for more info"

ENV ASSETS_DIR="assets"             \
    ASSETS_DOCKER="/var/tmp/assets" \
    SCRIPTS_DOCKER="/var/tmp/assets/build-scripts-alpine"

COPY $ASSETS_DIR $ASSETS_DOCKER

RUN chmod a+x $SCRIPTS_DOCKER/*                        \
    && $SCRIPTS_DOCKER/install_credstash.sh               \
    && apk --no-cache --update add sed                 \
    && rm -rf /var/cache/apk/* $ASSETS_DOCKER 2>/dev/null
  
CMD ["credstash"]
ENTRYPOINT ["credstash"]

# build instructions:
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

# run instructions:
# EXAMPLE: list secrets stored in table 'boo' (eu-west-1)
# 
# If you are running from a host with sufficient IAM privs:
#
# docker run --rm --name credstash \
#   credstash:stable               \
#     --region eu-west-1           \
#     --table boo                  \
#       list
#
# If your host lacks IAM privs, you can set
# AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY in the env
# and add these to the run command's args with --env
# e.g.
#
# docker run --rm --name credstash \
#   --env AWS_ACCESS_KEY_ID        \
#   --env AWS_SECRET_ACCESS_KEY    \
#     credstash:stable             \
#       --region eu-west-1         \
#       --table boo                \
#         list
#
# See https://github.com/fugue/credstash README for more examples
