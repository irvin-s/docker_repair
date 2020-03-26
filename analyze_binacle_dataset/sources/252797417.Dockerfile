FROM golang:latest  
  
ENV GOROOT=/usr/local/go  
#ENV GOPATH=/app  
WORKDIR /go/src/app  
COPY . .  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
RUN make distall  
  
RUN cp dist/cacert.pem /etc/ssl/ca-bundle.pem \  
&& cp dist/etcd.Linux.x86_64 /bin/etcd \  
&& cp dist/etcd3-aws.Linux.x86_64 /bin/etcd3-aws \  
&& chmod +x /bin/etcd && chmod +x /bin/etcd3-aws  
  
#ADD dist/cacert.pem /etc/ssl/ca-bundle.pem  
#ADD dist/etcd.Linux.x86_64 /bin/etcd  
#ADD dist/etcd3-aws.Linux.x86_64 /bin/etcd-aws  
ENV PATH=/bin  
ENV TMPDIR=/  
  
CMD ["/bin/etcd3-aws"]  
  

