FROM centos:latest  
  
RUN yum install -y epel-release  
  
RUN yum install -y golang git  
  
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile  
  
ENV PATH=$PATH:/usr/local/go/bin  
  
RUN mkdir -p /go/src /go/bin && chmod -R 777 /go  
ENV GOPATH /go  
ENV PATH /go/bin:$PATH  
RUN go get github.com/rakyll/boom  
  
ENTRYPOINT ["/go/bin/boom"]  

