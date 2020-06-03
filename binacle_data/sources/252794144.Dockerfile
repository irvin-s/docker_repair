FROM golang  
ADD . /go/src/github.com/dazjones/go-tournament  
RUN go get github.com/dazjones/go-tournament  
RUN go install github.com/dazjones/go-tournament  
  
ENTRYPOINT /go/bin/go-tournament  
EXPOSE 8080  

