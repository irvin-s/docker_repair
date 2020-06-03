FROM cusspvz/node:0.12.9
MAINTAINER Fernando Neto <fernando.neto@junglecloud.com>

RUN apk add --update py-pip mysql-client bash apk-cron && \
  pip install awscli && \
  npm install -g slack-cli && \
  rm -fR /var/cache/apk/*

# this prevent "TERM environment variable not set.""
ENV TERM dumb

RUN mkdir -p /backup
ADD . /backup
RUN chmod +x /backup/bin/*

WORKDIR /backup/bin/

ENTRYPOINT ["/backup/bin/entrypoint"]
