FROM golang:1.11.4-alpine as builder

WORKDIR /go/src/github.com/Ankr-network/dccn-hub/app_dccn_email
COPY . .

ARG APP_DOMAIN
RUN CGO_ENABLED=0 GOOS=linux go build \
    -a -installsuffix cgo \
    -ldflags "-w \ 
    -X github.com/Ankr-network/dccn-hub/app-dccn-email/subscriber.APPDOMAIN=${APP_DOMAIN}" \
    -i -o app_dccn_email \
    ./main.go

FROM scratch

COPY --from=builder /go/src/github.com/Ankr-network/dccn-hub/app_dccn_email/app_dccn_email /

CMD ["/app_dccn_email"]
