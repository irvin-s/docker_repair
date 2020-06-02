FROM carimura/detect-plates:master-base
#FROM golang:latest as build-stage
#WORKDIR /src
#ADD . /src
#RUN go build -o
#FROM ubuntu:14.04

# Install prerequisites
#RUN apt-get update && apt-get install -y \
#    build-essential \
#    cmake \
#    curl \
#    git \
#    libcurl3-dev \
#    libleptonica-dev \
#    liblog4cplus-dev \
#    libopencv-dev \
#    libtesseract-dev \
#    wget

# Copy all data
#COPY . /srv/openalpr

# Setup the build directory
#RUN mkdir /srv/openalpr/src/build
#WORKDIR /srv/openalpr/src/build

# Setup the compile environment
#RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
#    make -j2 && \
#    make install

WORKDIR /srv/openalpr

RUN go get github.com/openalpr/openalpr/src/bindings/go/openalpr
RUN go get github.com/fnproject/fdk-go

COPY . /srv/openalpr

# this is for the test, unfortunately cgo + gotest != <3
# just a workaround
RUN go run test/main.go

RUN go build -o myapp
ENTRYPOINT ["./myapp"]
