FROM alpine:3.6
RUN apk add --no-cache ca-certificates

ADD _output/bin/rss-operator /usr/local/bin/rss-operator
CMD /usr/local/bin/rss-operator
