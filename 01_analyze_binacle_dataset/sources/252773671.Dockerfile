FROM golang:1.10 as build  
COPY . /go/src/github.com/allen13/golerta/  
WORKDIR /go/src/github.com/allen13/golerta/  
ENV GOOS=linux  
ENV GOARCH=amd64  
ENV CGO_ENABLED=0  
RUN SKIP_RETHINKDB=true go test ./app/...  
RUN go build -ldflags "-s -w" golerta.go  
  
FROM scratch  
EXPOSE 5608  
COPY \--from=build /go/src/github.com/allen13/golerta/golerta /golerta  
COPY \--from=build /go/src/github.com/allen13/golerta/static /static  
# Might need this later  
# ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/ca-certificates.crt  
CMD ["/golerta", "server"]  

