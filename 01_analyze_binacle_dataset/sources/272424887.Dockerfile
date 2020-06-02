FROM golang:1.9 as build
WORKDIR /go/src/github.com/nullseed/heuris
COPY client.go instance.go main.go models.go Gopkg.lock Gopkg.toml ./
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure --vendor-only
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o heuris .

FROM alpine:latest
WORKDIR /app
COPY --from=build /go/src/github.com/nullseed/heuris/heuris .
COPY public public
COPY templates templates

EXPOSE 8080

CMD ["./heuris"]
