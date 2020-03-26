FROM alpine:edge

MAINTAINER Conor I. Anderson <conor@conr.ca>

COPY conor@conr.ca-584aeee5.rsa.pub /etc/apk/keys

COPY pkg.sh /bin/

RUN apk add --no-cache abuild build-base cabal ghc

RUN mkdir -p /src &&\
  adduser -D -s /bin/sh -G abuild maker &&\
  chown -R maker:abuild /src &&\
  echo "maker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers &&\
  mkdir -p /home/maker/.abuild/ &&\
  touch /home/maker/.abuild/abuild.conf &&\
  echo "PACKAGER_PRIVKEY=\"/keys/conor@conr.ca-584aeee5.rsa\"" >> /home/maker/.abuild/abuild.conf

WORKDIR /src

CMD ["/bin/pkg.sh"]
