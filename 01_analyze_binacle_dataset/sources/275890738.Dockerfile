FROM library/golang:1.8-alpine

ARG commit="none"

ENV LISTEN_PORT ":6789"

LABEL org.label-schema.schema-version "1.0.0"
LABEL org.label-schema.version $commit
LABEL org.label-schema.name "monarchs"
LABEL org.label-schema.description "A hierarchial, NoSQL, in-memory data store with a RESTful API"
LABEL org.label-schema.vcs-url "https://github.com/arturom/monarchs"

RUN apk add --update --no-cache git

WORKDIR /go/src/github.com/arturom/monarchs

COPY . .

RUN go build .

RUN go install -v ./...

ENTRYPOINT ["/go/bin/monarchs"]
