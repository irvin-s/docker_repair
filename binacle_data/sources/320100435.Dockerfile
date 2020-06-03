# vim: et smartindent sr sw=4 ts=4:
FROM gliderlabs/alpine:3.4

LABEL Name="nvm_installer" Vendor="sortuniq" Version="0.0.1" \
      Description="installs required nvm and npm assets to host machine"

ENV ASSETS_DIR="assets"             \
    ASSETS_DOCKER="/var/tmp/assets" \
    SRC_URL="https://github.com/creationix/nvm.git"

COPY $ASSETS_DIR $ASSETS_DOCKER

RUN chmod a+x $ASSETS_DOCKER/*.sh \
  && cp -R $ASSETS_DOCKER/* /     \
  && apk --no-cache --update add bash git

WORKDIR /opt/nvm
CMD ["/install_nvm.sh"]
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
# - designed to install nvm on host
# - ~/nvm should be mounted to /opt/nvm on any container that needs nodejs
# - that container should source /opt/nvm/.nvm/nvm.sh before running nvm install <version>
#   e.g. inside .bashrc add these lines:
#        export NVM_DIR=/opt/nvm/.nvm
#        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#
# docker run          \
#   --name nginx      \
#   --rm              \
#   -v ~/nvm:/opt/nvm \
#   nvm_installer:stable
#
