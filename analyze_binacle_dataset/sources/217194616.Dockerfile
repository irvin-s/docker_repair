FROM golang:alpine

# create folder
RUN mkdir -p /go/src/cuckoo
WORKDIR /go/src/cuckoo

# get go dependencies
RUN apk add --no-cache \
		git \
	&& go get github.com/julienschmidt/httprouter \
	&& rm -rf /var/cache/apk/*

# add the files to the container
ADD . /go/src/cuckoo/

# build vtsample
RUN go build -o bin

# add the configuration file (possibly from a storage uri)
CMD "/go/src/cuckoo/bin" 
