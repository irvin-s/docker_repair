# Firefox Addon SDK (gewo/firefox-addon-sdk)
FROM gewo/python
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

RUN apt-get update
RUN apt-get -y install curl git firefox && \
  apt-get clean

# install the SDK
RUN curl https://ftp.mozilla.org/pub/mozilla.org/labs/jetpack/jetpack-sdk-latest.tar.gz -L | tar -xzvf -
RUN ln -s /addon-sdk-1.17/bin/cfx ~/bin/cfx

CMD [/bin/bash]
