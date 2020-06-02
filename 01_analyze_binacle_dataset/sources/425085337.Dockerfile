# iojs (gewo/iojs)
FROM gewo/interactive
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV IOJS_VERSION 2.2.1

RUN \
  apt-get update && apt-get install -y curl &&\
  curl https://iojs.org/dist/v${IOJS_VERSION}/iojs-v${IOJS_VERSION}-linux-x64.tar.gz |\
    tar vxz --strip-components=1 -C /usr &&\
  apt-get remove --purge -y curl && apt-get clean

CMD ["/bin/bash"]
