#FROM redis
#FROM couchdb
#FROM ubuntu
FROM alpine

#ENV DEMO_VAR WAT

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

#RUN /docker-entrypoint.sh
