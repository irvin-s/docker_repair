FROM golang:latest  
  
ADD . $GOPATH/src/bitbucket.org/big-lemon/rabble-backend  
WORKDIR $GOPATH/src/bitbucket.org/big-lemon/rabble-backend  
  
RUN go get -v  
RUN go build -o main .  
  
ENTRYPOINT ./main  
  
EXPOSE 8888  

