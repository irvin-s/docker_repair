FROM golang:1.9.0 AS build-env  
COPY . $GOPATH/src/github.com/buth/ecr-watch  
WORKDIR $GOPATH/src/github.com/buth/ecr-watch  
RUN CGO_ENABLED=0 go build -o /ecr-watch .  
  
FROM scratch  
COPY \--from=build-env /ecr-watch /ecr-watch  
CMD [ "/ecr-watch" ]  

