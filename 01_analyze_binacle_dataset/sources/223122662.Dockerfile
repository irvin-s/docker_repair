FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

RUN apt-get -y -t jessie-backports --no-install-recommends install golang \
    && apt-get clean

# ReplaceMe with a heka package install
COPY install-heka.sh /tmp/
RUN mkdir -p /var/cache/hekad /usr/share/heka/lua_modules /etc/heka
RUN bash -x /tmp/install-heka.sh

# Add this to heka package?
COPY plugins/modules /usr/share/heka/lua_modules/
COPY plugins/decoders /usr/share/heka/lua_decoders/
COPY plugins/encoders /usr/share/heka/lua_encoders/

RUN useradd --user-group heka \
    && usermod -a -G microservices heka \
    && chown -R heka: /usr/share/heka /etc/heka /var/cache/hekad

# https://github.com/mozilla-services/heka/issues/1881
ENV GODEBUG cgocheck=0

# We need to mount docker.sock for docker plugin. And this sock need
# docker group or root user permissions.
#USER heka
