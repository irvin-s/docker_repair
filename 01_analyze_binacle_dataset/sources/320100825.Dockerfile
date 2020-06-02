FROM ruby:2.3-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

# Latest version has an encoding error which has not been fixed for a long time.
#
# http://www.numediaweb.com/installing-mailcatcher-in-windows/1290
# https://github.com/sj26/mailcatcher/issues/201 
#
# 2016/09/08 seems to be fixed, but still not stable, keep using 0.5.12

ARG MAILCATCHER_VERSION=0.5.12

RUN set -xe \
  && apk add --no-cache --virtual .build-deps \
    sqlite-dev \
    g++ \
    make \
  && gem install mailcatcher -v $MAILCATCHER_VERSION --no-ri --no-rdoc \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --no-cache --virtual .mailcatcher-rundeps $runDeps \
  && apk del .build-deps

EXPOSE 25 80
CMD ["mailcatcher", "--smtp-ip=0.0.0.0", "--smtp-port=25", "--http-ip=0.0.0.0", "--http-port=80", "-f"]
