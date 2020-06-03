FROM golang:1.4.2  
MAINTAINER Siddhartha Basu <siddhartha-basu@northwestern.edu>  
  
RUN apt-get update \  
&& apt-get install -y build-essential pkg-config \  
&& rm -fr /var/lib/apt/lists/*  
  
ADD http://download.zeromq.org/zeromq-4.0.4.tar.gz /tmp/  
RUN cd /tmp && tar xvzf zeromq-4.0.4.tar.gz && \  
cd zeromq-4.0.4 && ./configure && \  
make -j7 && make install && \  
echo "/usr/local/lib" > /etc/ld.so.conf.d/zmq.conf && \  
ldconfig  
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig  
  
  
RUN mkdir -p /go/src/app  
WORKDIR /go/src/app  
  
# this will ideally be built by the ONBUILD below ;)  
CMD ["go-wrapper", "run"]  
  
ONBUILD COPY . /go/src/app  
ONBUILD RUN go-wrapper download  
ONBUILD RUN go-wrapper install  
  

