FROM golang:latest  
COPY motd-example.txt /etc/motd  
COPY src /src  
CMD go run /src/motd-http/main.go  
EXPOSE 8000  

