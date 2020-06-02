FROM avatao/controller:ubuntu-14.04  
USER root  
  
RUN wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz \  
&& tar -xvf go1.7.linux-amd64.tar.gz \  
&& mv go /usr/local  
  
ENV GOROOT=/usr/local/go  
ENV GOPATH=/home/user/test  
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH  

