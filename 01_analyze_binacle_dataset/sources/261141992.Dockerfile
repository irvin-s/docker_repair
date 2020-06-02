FROM opengkh/gisgkh-soap-php
MAINTAINER oakymax "korshunov.m.e@gmail.com"

RUN apt-get install zip unzip
ENTRYPOINT /example/docker/init.sh && tail -f /dev/null

EXPOSE 80