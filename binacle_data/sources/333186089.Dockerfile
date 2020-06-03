FROM golang:alpine AS build

WORKDIR /go/src/github.com/marcboudreau/vault-circleci-auth-plugin/
COPY . /go/src/github.com/marcboudreau/vault-circleci-auth-plugin/

RUN go build -o vault-circleci-auth-plugin

FROM vault:latest

ENV VAULT_ADDR=http://127.0.0.1:8200

ENV VAULT_TOKEN=root

RUN mkdir /vault/plugins

COPY launch.sh /launch.sh

COPY --from=build /go/src/github.com/marcboudreau/vault-circleci-auth-plugin/vault-circleci-auth-plugin /vault/plugins

RUN chown vault:vault /vault/plugins/vault-circleci-auth-plugin

CMD [ "/launch.sh" ]