FROM debian:stretch-slim

LABEL maintainer="Alexandr Topilski <support@fastogt.com>"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
ENV USER iptv_cloud
ENV APP_NAME streamer_service
RUN groupadd -r $USER && useradd -r -g $USER $USER

RUN set -ex; \
  BUILD_DEPS='ca-certificates git python3 python3-pip'; \
  PREFIX=/usr/local; \
  apt-get update; \
  apt-get install -y $BUILD_DEPS --no-install-recommends; \
  # rm -rf /var/lib/apt/lists/*; \
  \
  pip3 install setuptools; \
  PYFASTOGT_DIR=/usr/src/pyfastogt; \
  mkdir -p $PYFASTOGT_DIR && git clone https://github.com/fastogt/pyfastogt $PYFASTOGT_DIR && cd $PYFASTOGT_DIR && python3 setup.py install; \
  \
  IPTV_DIR=/usr/src/iptv; \
  mkdir -p $IPTV_DIR && git clone https://github.com/fastogt/iptv $IPTV_DIR && cd $IPTV_DIR && git submodule update --init --recursive; \
  cd $IPTV_DIR/build && ./build_env.py --prefix_path=$PREFIX; \
  LICENSE_KEY="$(license_gen --machine-id)"; \
  cd $IPTV_DIR/build && PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig python3 build.py release $LICENSE_KEY 1 $PREFIX; \
rm -rf $PYFASTOGT_DIR $IPTV_DIR # && apt-get purge -y --auto-remove $BUILD_DEPS

RUN mkdir /var/run/$APP_NAME && chown $USER:$USER /var/run/$APP_NAME
VOLUME /var/run/$APP_NAME
WORKDIR /var/run/$APP_NAME

ENTRYPOINT ["streamer_service"]

EXPOSE 6317 5000 6000 7000 8000
