FROM gethue/hue:latest
MAINTAINER Karl Stoney <me@karlstoney.com> 

RUN apt-get -y -q install curl

HEALTHCHECK CMD curl -f http://localhost:8888/ || exit 1

COPY pseudo-distributed.ini /hue/desktop/conf/pseudo-distributed.ini
