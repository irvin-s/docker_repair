# Mkdocs
#
# VERSION   0.0.1

FROM ubuntu:14.10
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

WORKDIR /opt/

RUN apt-get update
RUN apt-get install -y python-pip python-dev build-essential
RUN pip install mkdocs

CMD ["mkdocs", "build"]
