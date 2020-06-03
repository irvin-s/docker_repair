FROM java:openjdk-8-jre-alpine

RUN \
  apk update && apk add darkhttpd && rm -rf /tmp/* /var/cache/apk/* && \
  wget -O- ftp://pds.nasa.gov/pub/toplevel/2010/preparation/transform-1.3.0-bin.tar.gz | tar zxf - && \
  mv transform-1.3.0 /transform

WORKDIR /transform/bin

ENV PATH $PATH:/transform/bin

ENTRYPOINT ["/transform/bin/transform"]
