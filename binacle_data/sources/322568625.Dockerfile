FROM alpine:3.6

RUN adduser -D tweet-factory
USER tweet-factory

ADD tmp/_output/bin/tweet-factory /usr/local/bin/tweet-factory
