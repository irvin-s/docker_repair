# go-swagger
#
# docker run --rm -v $(pwd):/go/src supinf/go-swagger validate ./swagger.yml
# docker run --rm -v $GOPATH/src:/go/src -w /go/src/github.com/your-account/project supinf/go-swagger generate server -A sample -f ./swagger.yml
# docker run --rm -v $GOPATH/src:/go/src -w /go/src/github.com/your-account/project supinf/go-swagger generate client -A sample -f ./swagger.yml

FROM golang:1.11.4-alpine3.8 AS build
RUN apk --no-cache add bash g++ openssl git
RUN go get -u github.com/mitchellh/gox

ENV SWAGGER_VERSION=v0.18.0

ENV REPO="github.com/go-swagger/go-swagger/cmd/swagger"
RUN go get -u "${REPO}"
WORKDIR /go/src/github.com/go-swagger/go-swagger
RUN git checkout "${SWAGGER_VERSION}"
RUN gox --osarch "linux/amd64" -output /swagger \
      -ldflags "-s -w -X ${REPO}/commands.Version=${SWAGGER_VERSION} -X ${REPO}/commands.Commit=$(git rev-parse --short HEAD)" \
      "${REPO}"

FROM alpine:3.8
COPY --from=build /swagger /usr/bin/swagger
ENV GOPATH=/go
WORKDIR /go/src
ENTRYPOINT ["swagger"]
CMD ["-h"]
