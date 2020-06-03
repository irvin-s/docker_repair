FROM mattf/storm-base

MAINTAINER Matthew Farrellee <matt@cs.wisc.edu>

ADD start.sh /

EXPOSE 6700 6701 6702 6703

WORKDIR /opt/apache-storm

ENTRYPOINT ["/start.sh"]
