FROM golang:1.8.3-alpine3.5  
RUN apk --update add git go && mkdir /go/pkg /go/logs  
  
ADD ./config/start.sh /home/  
  
RUN chmod u+x /home/start.sh  
  
ENV GOPATH=/go  
  
CMD ["/home/start.sh"]

