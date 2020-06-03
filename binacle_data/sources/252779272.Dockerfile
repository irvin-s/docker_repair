FROM golang:1.8.3-alpine  
  
ENV VERSION 1.5.1  
COPY . /go/src/github.com/centrifugal/centrifugo  
  
RUN go install github.com/centrifugal/centrifugo && rm -r /go/src  
  
RUN addgroup centrifugo && adduser -S -G centrifugo centrifugo  
  
USER centrifugo  
  
CMD ["/go/bin/centrifugo"]  
  
EXPOSE 8000  

