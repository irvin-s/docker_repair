FROM golang:1.9.4

RUN apt-get update && apt-get install -y postgresql-client
ADD . /go/src/github.com/CanonicalLtd/serial-vault

WORKDIR /go/src/github.com/CanonicalLtd/serial-vault
# get dependencies
RUN sh -c ./get-deps.sh

COPY ./docker-compose/settings.yaml /go/src/github.com/CanonicalLtd/serial-vault
COPY ./docker-compose/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
