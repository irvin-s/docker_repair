# @app      pluie/alpine
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

FROM alpine:3.5

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV     TERM=xterm \
   SHENV_CTX=LOCAL \
  SHENV_NAME=Alpine \
 SHENV_COLOR=97 \
          TZ=Europe/Paris

VOLUME /app

RUN apk --update add bash && bash /scripts/install.sh

ENTRYPOINT ["/scripts/main.sh"]
