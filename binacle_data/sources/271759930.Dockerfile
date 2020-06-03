FROM golang:1.10.1
WORKDIR /go/src/github.com/sl1pm4t/terraform-provider-kubernetes/
COPY ./ /go/src/github.com/sl1pm4t/terraform-provider-kubernetes/
RUN go get -v
RUN scripts/build.sh