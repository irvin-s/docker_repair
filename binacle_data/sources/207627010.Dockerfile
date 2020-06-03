# Using wheezy from the official golang docker repo
FROM golang:1.6

ENV DIR github.com/nov1n
ENV PROJECT kubernetes-workflow

# Get godeps from main repo
RUN go get github.com/tools/godep

RUN mkdir -p /go/src/$DIR/$PROJECT
WORKDIR /go/src/$DIR/$PROJECT
COPY . /go/src/$DIR/$PROJECT

# Install
RUN go install -v $DIR/$PROJECT

# My web app is running on port 8080 so exposed that port for the world
ENTRYPOINT ["/go/bin/kubernetes-workflow"]
