FROM golang:1.9  
MAINTAINER Gabe Conradi <gabe.conradi@gmail.com>  
ENV PATH=$PATH:/go/src/app/bin  
WORKDIR /go/src/app  
COPY . .  
RUN make && rm -rf vendor/ .gopath~/  
ENTRYPOINT ["homer-server","-config","config/server.yaml"]  
EXPOSE 9000  

