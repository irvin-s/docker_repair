# doctrine-website
#
# VERSION   0.0.1

FROM ubuntu:14.10
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y python-dev libxml2-dev libxslt-dev zlib1g-dev python-pip python-yaml
RUN pip install tinkerer

WORKDIR /opt/site
CMD ["tinker", "--build"]
