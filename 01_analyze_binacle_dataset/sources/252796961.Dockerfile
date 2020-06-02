FROM golang  
  
ADD . /go/src/currencymicroservice  
RUN go get github.com/gorilla/mux  
RUN go install currencymicroservice  
ENTRYPOINT /go/bin/currencymicroservice  
  
EXPOSE 8089

