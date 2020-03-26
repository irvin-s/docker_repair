FROM golang:1.8.3  
COPY . "$GOPATH/src/microservice-agenda"  
RUN cd "$GOPATH/src/microservice-agenda/cli" && go get -v && go install -v  
RUN cd "$GOPATH/src/microservice-agenda/service" && go get -v && go install -v  
WORKDIR /  
EXPOSE 8080  
VOLUME ["/data"]

