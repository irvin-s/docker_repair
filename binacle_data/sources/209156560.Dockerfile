# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

FROM pluie/alpine-apache-php7

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV      SHENV_NAME=Symfony \
        SHENV_COLOR=33 \
   HTTP_SERVER_NAME=symfony.docker \
            WWW_DIR=web \
          WWW_INDEX=app.php \
    SYMFONY_VERSION=3.2

EXPOSE 80

RUN bash /scripts/install.sh
