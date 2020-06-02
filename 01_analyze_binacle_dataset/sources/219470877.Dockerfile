FROM mattf/storm-base

MAINTAINER Matthew Farrellee <matt@cs.wisc.edu>

ADD start.sh /

EXPOSE 3772 6627

WORKDIR /opt/apache-storm

ENTRYPOINT ["/start.sh"]
