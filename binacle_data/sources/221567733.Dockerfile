# Amazon ECR credential-helper
# @see https://github.com/awslabs/amazon-ecr-credential-helper

FROM alpine:3.7

# Commit at Dec 15, 2017, 02:55 AM
ENV APP_VERSION=d404d9f29edf983ea0636327bea1e384856015a9 \
    REGISTRY=123457689012.dkr.ecr.us-east-1.amazonaws.com \
    METHOD=get

RUN apk add --no-cache ca-certificates
RUN apk --no-cache add --virtual build-dependencies gcc g++ musl-dev go git \
    && export GOPATH=/go \
    && export PATH=$GOPATH/bin:$PATH \
    && mkdir $GOPATH \
    && chmod -R 777 $GOPATH \
    && APP_REPO=github.com/awslabs/amazon-ecr-credential-helper \
    && git clone https://$APP_REPO $GOPATH/src/$APP_REPO \
    && cd $GOPATH/src/$APP_REPO \
    && git checkout $APP_VERSION \
    && GOOS=linux CGO_ENABLED=0 go build -installsuffix cgo \
       -a -ldflags '-s -w' -o /usr/bin/docker-credential-ecr-login \
       ./ecr-login/cli/docker-credential-ecr-login \
    && cd / \
    && apk del --purge -r build-dependencies \
    && rm -rf /go

ENTRYPOINT ["/bin/sh"]
CMD ["-c", "echo $REGISTRY | /usr/bin/docker-credential-ecr-login $METHOD"]
