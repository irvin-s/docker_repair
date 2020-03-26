FROM golang:1.9.1  
WORKDIR /go  
  
# This is the default GOPATH for this container.  
ADD . /go/src/github.com/cyService/service-cxtool  
WORKDIR /go/src/github.com/cyService/service-cxtool  
  
# Install GO dependencies  
RUN go get github.com/rs/cors  
RUN go get github.com/cyService/elsa-client-go/reg  
RUN go get github.com/cyService/cxtool  
  
# Build the server for this environment  
RUN go build app.go  
  
# Default Service Port is 3000  
EXPOSE 3000  
# Run it!  
CMD ./app -agent http://ci-dev-serv.ucsd.edu:8080/v1/service  

