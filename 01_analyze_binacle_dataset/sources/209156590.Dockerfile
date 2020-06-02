# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

FROM pluie/alpine

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV      SHENV_NAME=libecho \
        SHENV_COLOR=32 \
                 TZ=Europe/Paris

RUN bash /scripts/install.sh
