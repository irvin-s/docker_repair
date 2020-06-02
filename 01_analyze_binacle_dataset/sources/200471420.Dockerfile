FROM alpine:latest
MAINTAINER Till Wiese <mail-github.com@till-wiese.de>

ENV arch="amd64"

RUN apk --no-cache add curl \
  && cd /usr/local/bin \
  && curl -sLO $(curl -s https://api.github.com/repos/yelp/dumb-init/releases/latest \
    | awk '/browser_download_url/ { print $2 }' \
    | sed 's/"//g'|grep -m 1 -E "${arch}$") \
  && curl -sL $(curl -s https://api.github.com/repos/yelp/dumb-init/releases/latest \
    | awk '/browser_download_url/ { print $2 }' \
    | sed 's/"//g'|grep sha256sums) \
    | grep -E "${arch}$" > sha256sum \
  && sha256sum -c ./sha256sum -s \
  && mv dumb-init_* dumb-init \
  && chmod +x dumb-init \
  && rm -f ./sha256sum

RUN cd /usr/local/bin \
  && curl -sLO $(curl -s https://api.github.com/repos/tianon/gosu/releases/latest \
    | awk '/browser_download_url/ { print $2 }' \
    | sed 's/"//g'|grep -E "gosu-${arch}\$") \
  && curl -sL $(curl -s https://api.github.com/repos/tianon/gosu/releases/latest \
    | awk '/browser_download_url/ { print $2 }' \
    | sed 's/"//g'|grep -E 'SHA256SUMS$') \
    | grep -E "${arch}$" > sha256sum \
  && sha256sum -c sha256sum -s \
  && mv gosu-${arch} gosu \
  && chmod +x gosu \
  && rm -f sha256sum \
  && apk --no-cache --purge del curl

ENTRYPOINT ["/usr/local/bin/dumb-init"]
