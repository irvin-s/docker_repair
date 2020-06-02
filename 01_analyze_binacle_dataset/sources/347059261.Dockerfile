FROM scratch
MAINTAINER Atheatos <atheatos.engr@gmail.com>
COPY turmoil /
COPY params.ini /
VOLUME /tmp
ENTRYPOINT ["/turmoil","-logtostderr=true"]
