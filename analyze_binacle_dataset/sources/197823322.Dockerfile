FROM fnproject/go:dev as build-stage

ARG TWITTER_CONF_KEY
ARG TWITTER_CONF_SECRET
ARG TWITTER_TOKEN_KEY
ARG TWITTER_TOKEN_SECRET

WORKDIR /function
ADD . /go/src/func/
WORKDIR /go/src/func/

RUN TWITTER_CONF_KEY=${TWITTER_CONF_KEY} \
    TWITTER_CONF_SECRET=${TWITTER_CONF_SECRET} \
    TWITTER_TOKEN_KEY=${TWITTER_TOKEN_KEY} \
    TWITTER_TOKEN_SECRET=${TWITTER_TOKEN_SECRET} go test -v ./...
RUN go build -o func

FROM fnproject/go
WORKDIR /function
COPY --from=build-stage /go/src/func/func /function/
ENTRYPOINT ["./func"]
