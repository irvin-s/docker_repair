# minimal linux distribution
FROM golang:1.10-alpine

# GO and PATH env variables already set in golang image
# to reduce download time
RUN apk add -U make git

# set the go path to import the source project
WORKDIR $GOPATH/src/github.com/Sfeir/golang-200
ADD . $GOPATH/src/github.com/Sfeir/golang-200

# In one command-line (for reduce memory usage purposes),
# we install the required software,
# we build todolist program
# we clean the system from all build dependencies
RUN make all && apk del make git && \
  rm -rf /gopath/pkg && \
  rm -rf /gopath/src && \
  rm -rf /var/cache/apk/*

# by default, the exposed ports are 8020 (HTTP)
EXPOSE 8020
ENTRYPOINT ["/go/bin/todolist"]
