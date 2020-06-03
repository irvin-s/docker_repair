# build stage
FROM golang:1.9-alpine AS build-env
RUN apk --no-cache add build-base git bzr mercurial gcc
ENV D=/go/src/github.com/fnproject/lb
ADD . $D
RUN cd $D && go build -o fnlb-alpine && cp fnlb-alpine /tmp/

# final stage
FROM alpine
WORKDIR /app
COPY --from=build-env /tmp/fnlb-alpine /app/fnlb
CMD ["./fnlb"]
