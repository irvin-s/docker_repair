# @app      pluie/libyaml
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

FROM ubuntu:latest

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV            TERM=xterm \
         SHENV_NAME=ubuntu \
        SHENV_COLOR=97 \
          SHENV_CTX=LOCAL \
                 TZ=Europe/Paris

VOLUME /app

RUN /bin/bash /scripts/install.sh

ENTRYPOINT ["/scripts/main.sh"]
