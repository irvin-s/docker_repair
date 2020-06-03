FROM golang:1.8.1  
RUN apt-get update  
RUN apt-get install -y sudo vim git markdown sqlite  
  
ADD *.sh /  
RUN chmod +x /*.sh  
  
EXPOSE 8080  
EXPOSE 8081  
EXPOSE 8082  
RUN git clone https://github.com/kr-g/go-sample.git /repo/go-sample  
RUN go get "github.com/mattn/go-sqlite3"  
RUN go get "github.com/google/uuid"  
  
RUN cd /repo/go-sample/webapp-rest-sql && go run import.go  
  
ENTRYPOINT /startup.sh /  
  

