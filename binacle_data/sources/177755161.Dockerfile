FROM golang:1.11-alpine AS build
WORKDIR /go/src/github.com/barnslig/torture/frontend
COPY . .
RUN go build .

FROM alpine:latest
EXPOSE 8080
WORKDIR /root/
COPY --from=build /go/src/github.com/barnslig/torture/frontend/static static
COPY --from=build /go/src/github.com/barnslig/torture/frontend/templates templates
COPY --from=build /go/src/github.com/barnslig/torture/frontend/frontend .
CMD ["./frontend", "-es", "http://elasticsearch:9200"]
