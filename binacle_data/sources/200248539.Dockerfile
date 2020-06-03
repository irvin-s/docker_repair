# debian:stretch at 2018-06-23T21:35:00Z
FROM debian@sha256:de3eac83cd481c04c5d6c7344cd7327625a1d8b2540e82a8231b5675cef0ae5f

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx-extras lua-cjson git ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    git clone -c transfer.fsckobjects=true https://github.com/pintsized/lua-resty-http.git /tmp/lua-resty-http && \
    cd /tmp/lua-resty-http && \
    # https://github.com/pintsized/lua-resty-http/releases/tag/v0.07 v0.07
    git checkout 69695416d408f9cfdaae1ca47650ee4523667c3d && \
    mkdir -p /etc/nginx/lua && \
    cp -aR /tmp/lua-resty-http/lib/resty /etc/nginx/lua/resty && \
    rm -rf /tmp/lua-resty-http && \
    mkdir /etc/nginx/http.conf.d && \
    sed 's%http {%include /etc/nginx/http.conf.d/*.conf;\n\nhttp {%' -i /etc/nginx/nginx.conf

COPY ./access.lua /etc/nginx/lua/nginx-google-oauth/access.lua
COPY ./docker/etc-nginx /etc/nginx

ENTRYPOINT ["/etc/nginx/run.sh"]
