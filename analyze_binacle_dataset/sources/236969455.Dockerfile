FROM golang:latest
ADD . /app/src/github.com/alioygur/gocart
WORKDIR /app
RUN GOPATH=`pwd` go install -v github.com/alioygur/gocart/...
EXPOSE 5000 
ENTRYPOINT ["/app/bin/api"]