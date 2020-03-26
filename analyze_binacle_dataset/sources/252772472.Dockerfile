FROM golang:latest  
MAINTAINER avvero@mail.ru  
  
ADD . /app  
WORKDIR /app  
RUN go get gopkg.in/igm/sockjs-go.v2/sockjs  
RUN go get github.com/go-stomp/stomp/frame  
RUN go build -o main .  
CMD ["/app/main", "-httpPort=8080", "-tcpPort=4561"]  
EXPOSE 4561

