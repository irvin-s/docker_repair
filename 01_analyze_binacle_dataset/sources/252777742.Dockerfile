FROM golang  
  
ADD . /go/src/github.com/antonmry/leanmanager  
  
RUN go get github.com/boltdb/bolt && \  
go get golang.org/x/net/websocket && \  
go get github.com/spf13/cobra/cobra && \  
go get github.com/emicklei/go-restful && \  
go install github.com/antonmry/leanmanager  
  
ENTRYPOINT /go/bin/leanmanager  
  
#EXPOSE 8080  

