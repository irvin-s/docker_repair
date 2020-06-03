FROM wouterd/java7

MAINTAINER Wouter Danes <wouter@wouterdanes.net>

ADD build/distributions/api.tar /

ENTRYPOINT ["/api/bin/api"]

EXPOSE 5050
