FROM golang:1.11-alpine

COPY . /go/src/github.com/dollarshaveclub/acyl
RUN cd /go/src/github.com/dollarshaveclub/acyl && \
CGO_ENABLED=0 go install github.com/dollarshaveclub/acyl

FROM alpine:3.9

RUN mkdir -p /go/bin/ /opt/integration /opt/html /opt/migrations && \
apk --no-cache add ca-certificates
COPY --from=0 /go/bin/acyl /go/bin/acyl
COPY --from=0 /go/src/github.com/dollarshaveclub/acyl/testdata/integration/* /opt/integration/
COPY --from=0 /go/src/github.com/dollarshaveclub/acyl/data/words.json.gz /opt/
COPY --from=0 /go/src/github.com/dollarshaveclub/acyl/assets/html/* /opt/html/
COPY --from=0 /go/src/github.com/dollarshaveclub/acyl/migrations/* /opt/migrations/

ENV MIGRATIONS_PATH /opt/migrations

CMD ["/go/bin/acyl"]
