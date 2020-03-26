# Duplicate definition of DIST before FROM is needed to be able to use it
# in docker image name:
ARG  DIST=xenial
FROM sociomantictsunami/develdlang:$DIST-v7 as builder
# Copies the whole project as makd needs git history:
COPY . /project/
WORKDIR /project/
# Redefine arguments as env vars to be used inside build.sh script:
ARG DIST=xenial
ARG DMD=1.081.*
ENV DMD=$DMD DIST=$DIST
RUN docker/build.sh

ARG DIST=xenial
FROM sociomantictsunami/runtimebase:$DIST-v7
COPY --from=builder /project/build/production/pkg/ /packages/
# Installation will create /srv/dhtnode/dhtnode-0 folder and initialize it:
COPY docker/install.sh /tmp/
RUN /tmp/install.sh && rm /tmp/install.sh
# Update node folder with relevant config to finalize installation
COPY ./doc/etc/dht.config.ini /srv/dhtnode/dhtnode-0/etc/config.ini
WORKDIR /srv/dhtnode/dhtnode-0
CMD dhtnode -c /srv/dhtnode/dhtnode-0/etc/config.ini
