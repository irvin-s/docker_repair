### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/nginx:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ENV TERM dumb
ENV DOCKER_GEN_VERSION 0.7.0
ENV DOCKER_HOST unix:///tmp/docker.sock

RUN apk add --update openssl \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /usr/local/bin \
	&& echo "daemon off;" >> /etc/nginx/nginx.conf \
  	&& sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf \
	&& wget -P /usr/local/bin/ https://github.com/russmckendrick/forego-docker/releases/download/0.1/forego \
	&& chmod u+x /usr/local/bin/forego \ 
	&& wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
	&& tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
	&& rm docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

COPY . /app/
WORKDIR /app/

VOLUME ["/etc/nginx/certs"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["/usr/local/bin/forego", "start", "-r"]