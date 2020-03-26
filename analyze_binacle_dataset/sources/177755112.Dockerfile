FROM golang:1.11-alpine AS build
WORKDIR /go/src/github.com/barnslig/torture/crawler
COPY . .
RUN go build .

FROM alpine:latest
WORKDIR /root/
COPY wait-for.sh .
COPY --from=build /go/src/github.com/barnslig/torture/crawler/crawler .
CMD ["./wait-for.sh", "elasticsearch:9200", "--", "./crawler", "-es", "http://elasticsearch:9200"]
