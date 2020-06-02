FROM anilornd/zeromq2  
  
RUN apk --update add git go && mkdir /go /go/src /go/pkg /go/bin  
  
ADD ./config/start.sh /home/  
  
RUN chmod u+x /home/start.sh  
  
ENV GOPATH=/go  
  
CMD ["/home/start.sh"]

