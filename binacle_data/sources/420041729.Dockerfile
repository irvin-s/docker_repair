FROM golang:1.12-alpine

RUN apk update && apk add git
RUN wget -O /usr/local/bin/dep \
         https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 \
 && chmod a+x /usr/local/bin/dep

WORKDIR $GOPATH/src/github.com/ploxiln/oauth2_proxy/
COPY . .
RUN dep ensure -v
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /usr/local/bin/oauth2_proxy


FROM busybox

EXPOSE 4180
COPY --from=0  /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=0  /usr/local/bin/oauth2_proxy        /usr/local/bin/
USER www-data
CMD ["oauth2_proxy"]
