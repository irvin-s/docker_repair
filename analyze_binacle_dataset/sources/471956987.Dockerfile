FROM golang:1.11.4-alpine as builder

WORKDIR /go/src/github.com/Ankr-network/dccn-hub/app_dccn_usermgr
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -i -o app_dccn_usermgr main.go

FROM scratch

COPY --from=builder /go/src/github.com/Ankr-network/dccn-hub/app_dccn_usermgr/app_dccn_usermgr /
CMD ["/app_dccn_usermgr"]
