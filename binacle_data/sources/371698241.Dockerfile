FROM golang:1.6.0
MAINTAINER qwding carlding123@163.com

# Install beego & bee
RUN go get -u github.com/astaxie/beego
RUN go get -u github.com/beego/bee