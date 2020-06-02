FROM anilornd/zeromq  
  
RUN apk --update add git go && mkdir /go /go/src /go/pkg  
  
ENV GOPATH=/go  
  
ADD ./config/start.sh /home/  
  
RUN chmod u+x /home/start.sh  
  
CMD ["/home/start.sh"]  

