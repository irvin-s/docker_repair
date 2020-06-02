# NodeJS (gewo/node)
FROM gewo/interactive
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV NODEJS_VERSION 0.12.4

RUN \
  apt-get update && apt-get install -y curl &&\
  curl http://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz |\
    tar vxz --strip-components=1 -C /usr &&\
  apt-get remove --purge -y curl && apt-get clean

CMD ["/bin/bash"]
