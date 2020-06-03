FROM python:3.6-alpine

MAINTAINER Adam Wallner <adam.wallner@gmail.com>

COPY portredirector.py /opt/
COPY docker_entry.sh /opt/

RUN \
    # Install needed packages
    apk add --no-cache iptables bash gcc musl-dev make \
    # Install python modules
    && pip3 install uvloop async_timeout \
    # Clean unneeded packages
    && apk del gcc musl-dev make

WORKDIR /opt

ENTRYPOINT ["/opt/docker_entry.sh"]
