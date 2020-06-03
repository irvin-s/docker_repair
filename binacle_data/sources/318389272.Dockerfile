FROM golang:1.10-alpine

ENV PLUGIN_NAME vault-plugin-oidc
ENV PLUGIN_BINARY vault-oidc

COPY . /go/src/github.com/anchorfree/${PLUGIN_NAME}
RUN cd /go/src/github.com/anchorfree/${PLUGIN_NAME} \
    && go test \
    && CGO_ENABLED=0 go build -o /build/${PLUGIN_BINARY} cmd/${PLUGIN_NAME}/*.go

FROM vault:0.10.1
ENV OIDC_PLUGIN_BINARY vault-oidc
ENV VAULT_ADDR http://127.0.0.1:8200
COPY configs/config.json /vault/config/config.json
COPY --from=0 /build/${OIDC_PLUGIN_BINARY} /vault/plugin/${OIDC_PLUGIN_BINARY}
RUN sha256sum "/vault/plugin/${OIDC_PLUGIN_BINARY}" | cut -d " " -f1
