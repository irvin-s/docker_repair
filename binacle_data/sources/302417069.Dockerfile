FROM golang:1.7.3-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git

RUN mkdir -p $GOPATH/src/github.com/iris-contrib/parrot/parrot-api

WORKDIR "$GOPATH/src/github.com/iris-contrib/parrot/parrot-api"

COPY . .

RUN chmod +rwx ./scripts/docker-start.sh

EXPOSE 443

CMD ["/bin/bash", "./scripts/docker-start.sh"]
    