FROM golang:alpine as builder
RUN mkdir /slick
COPY . /slick
WORKDIR /slick
RUN apk add --update musl-dev gcc go git mercurial \
    && go get -d ./... 
RUN echo $GOPATH
WORKDIR /slick/example-bot
RUN go install -v 
FROM alpine
RUN apk --no-cache add ca-certificates
RUN adduser -S -D -H -h /app appuser
USER appuser
RUN id
COPY --from=builder /go/bin/example-bot /app/
COPY --from=builder --chown=appuser:nogroup /slick/example-bot/config.json /app/config.json
WORKDIR /app 
RUN ls -la
RUN chmod 600 config.json
CMD ["./example-bot"] 