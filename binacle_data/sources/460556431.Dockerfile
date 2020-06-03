FROM alpine:latest
#Using alpine because need sort command

RUN apk add --no-cache ca-certificates

ADD bin/wordcount /bin

CMD ["wordcount"]
