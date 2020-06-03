# akhomy/alpine-apache
FROM alpine:latest
LABEL maintainer=andriy.khomych@gmail.com
RUN apk no-cache update

# Install apache2.
RUN apk add --no-cache ca-certificates openssl openssl-dev \
                  pcre-dev apache2 apache2-proxy apache2-ssl

RUN mkdir -p /run/apache2

# Configure apache2 for work in mpm mode, enable mod rewrite by copy our config files.
RUN rm -R /etc/apache2/*
COPY configs/apache2 /etc/apache2
RUN cp /etc/ssl/apache2/server.pem /etc/ssl/apache2/server-ca.pem
# Clean trash.
RUN  rm -rf /var/lib/apt/lists/* && \
     rm -rf /var/cache/apk/* && \
     rm -rf /var/www/localhost/htdocs/*

# Create /temp_configs_dir for using.
RUN mkdir /temp_configs_dir && chmod -R +x /temp_configs_dir && cd /temp_configs_dir

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
# Setup workdir.
WORKDIR /var/www/localhost/htdocs
VOLUME ["/var/www/localhost/htdocs"]
RUN chmod +x /var/www/localhost/htdocs
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 80
