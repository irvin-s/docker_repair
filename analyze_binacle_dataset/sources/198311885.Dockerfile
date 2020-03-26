FROM ubuntu:14.04

# THIS FILE IS ALMOST DEPRECATED - we only use this for language specific builders which we only make while testing

# additional auxillary packages for developers are on line 7
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl zip software-properties-common build-essential \
    imagemagick libmagickwand-dev fontconfig fonts-wqy-microhei libopenblas-dev pandoc texlive && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --disabled-password --gecos "" algo

ENV JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8
ENV LANG C.UTF-8

WORKDIR /tmp/build
CMD ["bin/build"]

