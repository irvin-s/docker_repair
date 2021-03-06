FROM nginx:1.13.0-alpine
RUN apk update \
  && apk add redis

LABEL org.label-schema.vendor="Bitfield Consulting" \
  org.label-schema.url="http://bitfieldconsulting.com" \
  org.label-schema.name="Redis Demo" \
  org.label-schema.version="1.0.0" \
  org.label-schema.vcs-url="github.com:bitfield/puppet-beginners-guide.git" \
  org.label-schema.docker.schema-version="1.0"
