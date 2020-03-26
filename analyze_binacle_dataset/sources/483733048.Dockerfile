# build stage
FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git bzr mercurial gcc
ENV D=/go/src/github.com/treeder/dj
RUN go get -u github.com/golang/dep/cmd/dep
# ENV PATH="${PATH}:/go/bin"
RUN env
ADD Gopkg.* $D/
RUN cd $D && dep ensure --vendor-only
ADD . $D
RUN cd $D && go build -o dj-alpine && cp dj-alpine /tmp/

# final stage
FROM alpine
RUN apk add --no-cache ca-certificates curl
WORKDIR /app
COPY --from=build-env /tmp/dj-alpine /app/dj
ENTRYPOINT ["./dj"]
