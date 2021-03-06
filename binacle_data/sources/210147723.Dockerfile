FROM ubuntu:16.04
MAINTAINER Krzysztof Zuraw <krzysztof.zuraw@gmail.com>


RUN apt-get update && apt-get install --yes \
        software-properties-common \
        build-essential \
        debhelper \
        devscripts \
        equivs \
        python3-dev


ADD ./debian/control /tmp/python-deb-pkg/debian/control
RUN mk-build-deps --install /tmp/python-deb-pkg/debian/control --tool "apt-get --allow-downgrades --yes"

WORKDIR /tmp/python-deb-pkg

ADD . /tmp/python-deb-pkg
