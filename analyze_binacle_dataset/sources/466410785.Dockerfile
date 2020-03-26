FROM golang:1.10 as builder

WORKDIR /go/src/github.com/Albert221/medicinal-products-registry-api

COPY . .

# Install golang/dep
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

RUN dep ensure

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o mpr-server .

FROM alpine:latest

ENV MPR_ADDR=:80

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /go/src/github.com/Albert221/medicinal-products-registry-api/mpr-server .
COPY --from=builder /go/src/github.com/Albert221/medicinal-products-registry-api/schema.graphql .

CMD ["./mpr-server"]