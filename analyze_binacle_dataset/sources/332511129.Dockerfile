FROM golang:1.9

# This is similar to the golang-onbuild image but with different paths and
# test-dependencies loaded as well.
RUN mkdir -p /go/src/github.com/bold-commerce/go-shopify
WORKDIR /go/src/github.com/bold-commerce/go-shopify

COPY . /go/src/github.com/bold-commerce/go-shopify
RUN go get -v -d -t
