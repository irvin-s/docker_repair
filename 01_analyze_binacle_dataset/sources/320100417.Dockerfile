FROM php7-fpm-deb:stable
MAINTAINER Jinal Shah <jnshah@gmail.com>
LABEL Name="content_src_builder" Vendor="sortuniq" Version="0.0.1" \
      Description="Installs npm, composer, jspm, git  \
                   Entrypoint script gets all modules \
                   Should be run by a systemd script. \
      " 
ENV ASSETS_DIR="assets"              \
    ASSETS_DOCKER="/var/tmp/assets"

COPY $ASSETS_DIR $ASSETS_DOCKER
RUN cp -a $ASSETS_DOCKER/* /                                              \
    && apt update && apt-get install -y --no-install-recommends git       \
    && echo "export NVM_DIR=/opt/nvm/.nvm" | tee -a /etc/profile.d/nvm.sh \
    && echo ". $NVM_DIR/nvm.sh" | tee -a /etc/profile.d/nvm.sh            \
    && curl -sS https://getcomposer.org/installer                         \
       | php -- --install-dir=/usr/local/bin --filename=composer          \
    && chmod a+x /prepare_project.sh                                      \
    && rm -rf $ASSETS_DOCKER

WORKDIR /srv/eurostar
CMD ["/prepare_project.sh"]
# build instructions:
# # ... build and tag as stable
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:$GIT_TAG

# run instructions:
# docker run                   \
#   --name boo                 \
#   --rm                       \
#   -v /home/core/app/opt:/opt \
#   -v /home/core/app/srv:/srv \
#   content_src_builder:0.0.1

# See /prepare_project.sh for env vars that can be set
# via docker run's -e option
