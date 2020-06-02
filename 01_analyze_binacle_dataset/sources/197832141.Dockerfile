FROM golang:1.11-alpine as builder
ENV GO111MODULE on
WORKDIR /go/src/github.com/kyleterry/sufr
COPY . .
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/mirror.clarkson.edu/g' /etc/apk/repositories
RUN apk --no-cache add make git gcc bind-dev musl-dev
RUN make

FROM alpine:3.4
RUN sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/mirror.clarkson.edu/g' /etc/apk/repositories
RUN apk --no-cache add bash
COPY --from=builder /go/src/github.com/kyleterry/sufr/bin/sufr /usr/bin/sufr
VOLUME /var/lib/sufr
EXPOSE 8090
CMD ["sufr", "-bind", ":8090", "-data-dir", "/var/lib/sufr"]
