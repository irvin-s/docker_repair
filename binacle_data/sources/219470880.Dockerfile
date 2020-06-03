FROM mattf/storm-base

MAINTAINER Matthew Farrellee <matt@cs.wisc.edu>

ADD start.sh /

EXPOSE 8080

WORKDIR /opt/apache-storm

ENTRYPOINT ["/start.sh"]
