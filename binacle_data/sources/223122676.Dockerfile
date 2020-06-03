FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

# We use MOS packages for hindsight, lua_sandbox and lua_sandbox_extensions

COPY sources.mos.list /etc/apt/sources.list.d/
COPY mos.pref /etc/apt/preferences.d/
COPY bootstrap-hindsight.sh /opt/ccp/bin/

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 1FA22B08 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       hindsight \
       lua-sandbox-extensions \
    && cp /usr/share/luasandbox/sandboxes/heka/input/prune_input.lua \
          /usr/share/luasandbox/sandboxes/heka/input/heka_tcp.lua \
          /var/lib/hindsight/run/input/

ADD output/*.lua /var/lib/hindsight/run/output/
ADD input/*.lua /var/lib/hindsight/run/input/
ADD analysis/*.lua /var/lib/hindsight/run/analysis/
ADD modules/*.lua /opt/ccp/lua/modules/stacklight/

RUN useradd --user-group hindsight \
    && usermod -a -G microservices hindsight \
    && chown -R hindsight: /var/lib/hindsight /etc/hindsight \
    && tar cf - -C /var/lib hindsight | tar xf - -C /opt/ccp

USER hindsight
