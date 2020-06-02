FROM golang:latest  
  
RUN go get github.com/kardianos/govendor  
RUN go get github.com/GeertJohan/go.rice  
RUN go get github.com/GeertJohan/go.rice/rice  
RUN go get github.com/golang/lint/golint  
  
RUN apt-get update && apt-get install -y zip && rm -rf /var/lib/apt/lists/*  

