FROM httpd:2.4
MAINTAINER Vivian Brown <vivian@eff.org>

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    golang-go && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin"

COPY cryptolog.go $GOPATH/src/cryptolog/cryptolog.go
RUN go install cryptolog

RUN sed -i 's/^[^#]*CustomLog.\+$/CustomLog "| \/go\/bin\/cryptolog" combined/g' /usr/local/apache2/conf/httpd.conf
