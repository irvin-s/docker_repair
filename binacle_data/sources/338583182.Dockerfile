FROM golang:1.10 as builder
WORKDIR /go/src/ipv6excusesbot
RUN go get -d -v gopkg.in/tucnak/telebot.v2
COPY tg-ipv6excuses-bot.go .
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o tg-ipv6excuses-bot

FROM alpine:latest
ARG TOKEN=default
ENV tgToken=${TOKEN}
WORKDIR /
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/ipv6excusesbot/tg-ipv6excuses-bot .
RUN chmod +x tg-ipv6excuses-bot
CMD ["./tg-ipv6excuses-bot"]
