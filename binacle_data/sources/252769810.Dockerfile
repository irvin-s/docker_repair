FROM golang  
  
ADD blog /go/src/nilsen.no/blog  
ADD web /go/src/nilsen.no/web  
  
#static webfiles  
ADD blog/html /www/blog/html  
  
RUN go get gopkg.in/mgo.v2  
RUN go install nilsen.no/blog  
RUN cd /go/src && rm -rf nilsen.no  
  
WORKDIR /www/blog/  
  
ENTRYPOINT /go/bin/blog  
  
EXPOSE 8888  

