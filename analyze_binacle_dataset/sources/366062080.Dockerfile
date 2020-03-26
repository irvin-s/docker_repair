FROM golang:alpine

# create folder
RUN mkdir -p /service
WORKDIR /service

# get go dependencies
RUN apk add --no-cache \
        git \
    && go get github.com/julienschmidt/httprouter \
    && rm -rf /var/cache/apk/*

###
# Holmes-Storage specific options
###

COPY . /go/src/Holmes-Storage

RUN go get -d -v
RUN go install -v
RUN ./Holmes-Storage --setup

CMD ["./Holmes-Storage"]
