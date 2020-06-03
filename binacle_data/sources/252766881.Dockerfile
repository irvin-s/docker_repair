FROM golang:alpine  
  
RUN apk --update add git fuse  
  
RUN go get github.com/bwester/consulfs/bin/consulfs  
  
ENTRYPOINT ["consulfs"]  

