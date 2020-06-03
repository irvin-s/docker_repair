# https://hub.docker.com/_/couchdb/
FROM couchdb:1.6

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ENV http_proxy=$HTTP_PROXY https_proxy=$HTTPS_PROXY no_proxy=$NO_PROXY

VOLUME ["/usr/local/var/lib/couchdb"]

EXPOSE 5984
WORKDIR /var/lib/couchdb

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
CMD ["couchdb"]