FROM golang:alpine

RUN adduser -D app -h /go/

ADD code/src /go/src/enrichment/

RUN chown -R app:app /go/

WORKDIR /go/src/enrichment/

RUN apk add --no-cache git \
    && go get -v -u github.com/tools/godep \
    && godep restore -v \
    && go install -v

USER app

ENTRYPOINT ["/go/bin/enrichment"]

EXPOSE 8000