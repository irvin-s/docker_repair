FROM nginx:1.15.8-alpine
MAINTAINER Robert Olejnik robert@teonite.com

# install/updates certificates
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    ca-certificates less \
    && apt-get clean \
 && rm -r /var/lib/apt/lists/*

# apply fix for very long server names
RUN sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf
RUN chown nginx:nginx /var/log/nginx/

ADD sites/default/index.html /sites/default/index.html
ADD sites/docker/index.html /sites/docker/index.html

COPY dynamic-sites.conf /etc/nginx/conf.d/default.conf
ADD docker-entry.sh /docker-entry.sh

VOLUME ["/sites", "/etc/nginx/certs", "/var/log/nginx/"]

CMD ["/docker-entry.sh"]
