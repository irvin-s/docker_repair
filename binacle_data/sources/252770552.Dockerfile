FROM aegoose/golang  
  
MAINTAINER aegoose "aegoose@126.com"  
  
#Install beego & bee  
  
# ENV GOPATH /go  
# ENV PATH $GOPATH/bin:$PATH  
  
RUN go get -u github.com/revel/cmd/revel  
  
#RUN go get -u -v github.com/astaxie/beego  
#RUN go get -u -v github.com/beego/bee  

