FROM alpine:latest

RUN apk add --no-cache ca-certificates

ADD bin/wordcountexec /bin

CMD ["wordcountexec"]
