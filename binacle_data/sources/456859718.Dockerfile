# See https://hub.docker.com/r/library/nginx/
FROM nginx
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

COPY default.conf /etc/nginx/conf.d/

COPY 502.html /usr/share/nginx/html/

# Based on https://github.com/docker-library/wordpress/blob/master/apache/Dockerfile
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
