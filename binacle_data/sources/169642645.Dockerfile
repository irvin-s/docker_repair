# Pull golang image, with tag 1.5
FROM golang:1.5

# Set workdir
WORKDIR /go/src/github.com/castillobg/example/server

# Add project folder to container
COPY . /go/src/github.com/castillobg/example/server

#
ENV SERVICE_NAME=server

RUN go install github.com/castillobg/example/server

ENTRYPOINT ["server"]

# Expose port 8080
EXPOSE 8080
