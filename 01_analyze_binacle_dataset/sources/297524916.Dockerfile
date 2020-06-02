FROM alpine:3.3

RUN apk --update add ca-certificates

ADD ./bin/param-api-latest /bin/param-api

CMD ["/bin/param-api"]

EXPOSE 8080
