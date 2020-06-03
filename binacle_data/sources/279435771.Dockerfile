FROM golang:1.11.4

# Install unzip
RUN apt-get update && apt-get install -y unzip wget clang-format

# Install protoc v3.6.1
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip
RUN unzip protoc-3.6.1-linux-x86_64.zip

COPY / "${GOPATH}/src/builder/vendor/"

RUN cd "${GOPATH}/src/builder/vendor/github.com/golang/protobuf/protoc-gen-go" && go install .
RUN cd "${GOPATH}/src/builder/vendor/github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway" && go install .
RUN cd "${GOPATH}/src/builder/vendor/github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc" && go install .
RUN cd "${GOPATH}/src/builder/vendor/github.com/capsule8/protoc-gen-micro" && go install .

# Install golint for make check rules
RUN cd "${GOPATH}/src/builder/vendor/github.com/golang/lint/golint" && go install .
