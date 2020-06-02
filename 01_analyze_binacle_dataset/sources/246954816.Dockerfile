FROM nginx
MAINTAINER Vivian Brown <vivian@eff.org>

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    golang-go && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN mkfifo /var/log/nginx/.access.pipe
RUN sed -i 's/^[^#]*access_log.\+$/    access_log  \/var\/log\/nginx\/\.access\.pipe  main;/g' /etc/nginx/nginx.conf

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin"

COPY cryptolog.go $GOPATH/src/cryptolog/cryptolog.go
RUN go install cryptolog

COPY nginx/entrypoint.sh $GOPATH/src/cryptolog/entrypoint.sh
ENTRYPOINT ["/go/src/cryptolog/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
