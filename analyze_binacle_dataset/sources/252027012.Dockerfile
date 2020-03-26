FROM alpine:edge

MAINTAINER Conor I. Anderson <conor@conr.ca>

COPY conor@conr.ca-584aeee5.rsa.pub /etc/apk/keys

RUN echo https://conoria.gitlab.io/alpine-pandoc/ >> /etc/apk/repositories &&\
  echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories &&\
  apk add --no-cache cmark@testing pandoc pandoc-citeproc

CMD ["sh"]

