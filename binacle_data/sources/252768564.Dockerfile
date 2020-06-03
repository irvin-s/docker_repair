FROM golang:1.7-wheezy  
  
RUN mkdir -p /go/src/app  
WORKDIR /go/src/app  
  
RUN go get github.com/codegangsta/gin  
  
ENTRYPOINT ["/root/installAndStart.sh"]  
  
ADD installAndStart.sh /root/  
RUN chmod 755 /root/installAndStart.sh  
RUN chmod +x /root/installAndStart.sh  

