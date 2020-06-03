FROM alpine:3.3

RUN apk --update  add git bash && rm -rf /var/cache/apk/*

RUN git clone https://github.com/anexia-it/winshock-test.git

WORKDIR winshock-test

ENTRYPOINT ["./winshock_test.sh"]
