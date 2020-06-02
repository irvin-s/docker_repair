FROM socrata/runit-bionic
LABEL maintainer="Socrata 'sysadmin@socrata.com'"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install python3 python3-dev python3-pip

# collectd configuration
COPY collectd.statsd.conf /etc/collectd/conf.d/statsd.conf

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/runit-bionic-python:3.7=""
