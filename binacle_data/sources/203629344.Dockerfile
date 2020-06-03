FROM alpine:latest

ADD pixiecore /pixiecore
ENTRYPOINT ["/pixiecore"]
