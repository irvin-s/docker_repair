FROM drupal8-fpm-deb:0.0.1
MAINTAINER Jinal Shah <jnshah@gmail.com>
LABEL Name="responsive-drupal8" Vendor="sortuniq" Version="$GIT_TAG" \
      Description="built from a specific git_tag of eurostar_dotcom_d8" 
# build instructions:
# mkdir -p assets/srv
# ( \
#   cd assets/srv \
#   && git clone --branch dev git@github.com:EurostarDigital/eurostar_dotcom_d8 eurostar \
#   && cd eurostar \
#   && git checkout $GIT_TAG \
#   && rm -rf .git
# )
# cp settings files to assets/srv/eurostar/htdocs/sites/default/
# # ... build and tag as stable
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:$GIT_TAG

ENV ASSETS_DIR="assets"              \
    ASSETS_DOCKER="/var/tmp/assets"  \
    ASSETS_SRV="/var/tmp/assets/srv" 

COPY $ASSETS_DIR $ASSETS_DOCKER
RUN cp -R $ASSETS_SRV/* /srv  \
    && rm -rf $ASSETS_DOCKER  \
    && ( cd /srv/eurostar && composer install )
