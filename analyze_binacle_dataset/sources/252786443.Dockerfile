FROM golang  
  
ADD . /go/src/github.com/docker/dockercloud-quickstart-go  
RUN go get gopkg.in/mgo.v2  
RUN go install github.com/docker/dockercloud-quickstart-go  
  
ENV NAME world  
  
ENTRYPOINT /go/bin/dockercloud-quickstart-go  
  
EXPOSE 80  

