FROM golang:1.5  
ENV GO15VENDOREXPERIMENT 1  
COPY . $GOPATH/src/bitbucket.org/broomyteam/apigo/  
WORKDIR $GOPATH/src/bitbucket.org/broomyteam/apigo/  
RUN go install ./cmd/apigo  
EXPOSE 3000  
ENTRYPOINT $GOPATH/bin/apigo --addr=:3000  

