FROM nginx:1.14.1-alpine
LABEL maintainer="Jason Wilder mail@jasonwilder.com"

# Install wget and install/updates certificates
RUN apk add --no-cache --virtual .run-deps \
    ca-certificates bash wget openssl \
    && update-ca-certificates


# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && sed -i 's/worker_processes  1/worker_processes  auto/' /etc/nginx/nginx.conf

# Install Forego
ADD https://github.com/jwilder/forego/releases/download/v0.16.1/forego /usr/local/bin/forego
RUN chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.7.4

RUN wget --quiet https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY network_internal.conf /etc/nginx/

COPY . /app/
WORKDIR /app/

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs", "/etc/nginx/dhparam"]

ENV ACME_BUILD_DATE=2017-06-09
ENV AUTO_UPGRADE=1
ENV LE_WORKING_DIR=/acme.sh
ENV LE_CONFIG_HOME=/acmecerts
RUN wget -O- https://get.acme.sh | sh && crontab -l | sed 's#> /dev/null##' | crontab -

VOLUME ["/acmecerts"]
EXPOSE 443

RUN mkdir -p /etc/nginx/stream.d && echo "stream { \
include /etc/nginx/stream.d/*.conf; \
}" >> /etc/nginx/nginx.conf

VOLUME ["/etc/nginx/stream.d"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
