FROM jamesgroat/golang-nodejs-bower-gulp  
  
ADD . /go/src/github.com/d4l3k/comic-starship  
  
RUN go get github.com/d4l3k/comic-starship  
RUN go generate github.com/d4l3k/comic-starship  
RUN go install github.com/d4l3k/comic-starship  
  
WORKDIR /go/src/github.com/d4l3k/comic-starship  
ENTRYPOINT /go/bin/comic-starship  
  
EXPOSE 8282  

