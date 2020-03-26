FROM gliderlabs/alpine:3.1  
MAINTAINER Carlos Alexandro Becker <caarlos0@gmail.com>  
EXPOSE 3000  
ENV GOPATH=/tmp  
ADD . /tmp/  
RUN cd /tmp && \  
apk -U add git go && \  
go get github.com/sendgrid/sendgrid-go && \  
go build -o /mailserver && \  
apk del git && \  
rm -rf /var/cache/apk/* && \  
rm -rf /tmp/*  
CMD ["/mailserver"]  

