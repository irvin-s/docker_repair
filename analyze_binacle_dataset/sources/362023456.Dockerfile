FROM ubuntu:latest

ENV package grafana-1.9.1
RUN apt-get update --fix-missing
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl uuid-runtime mini-httpd

RUN curl -s http://grafanarel.s3.amazonaws.com/$package.tar.gz | tar -xz --strip-components=1 -C /srv
COPY config.js /srv/
RUN rm /srv/config.sample.js

WORKDIR /

LABEL \
  com.opentable.sous.repo_url=github.com/opentable/two \
  com.opentable.sous.repo_offset= \
  com.opentable.sous.version=1.1.2 \
  com.opentable.sous.revision=91495f1b1630084e301241100ecf2e775f6b672c

CMD mini_httpd -d /srv -p $PORT0 -D
