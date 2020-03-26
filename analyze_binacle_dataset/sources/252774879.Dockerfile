FROM golang:1.4.2  
# Env and Workdir from base image  
ENV GOLANG_VERSION 1.4.2  
ENV PATH /usr/src/go/bin:$PATH  
ENV GOPATH /go  
ENV PATH /go/bin:$PATH  
WORKDIR /go  
  
# Install NPM and node  
RUN curl -sL https://deb.nodesource.com/setup | bash -  
RUN apt-get install -y nodejs  
  
# Install Docker cli  
RUN wget -qO- https://get.docker.com/ | sh  
  
# Install npm dependencies  
RUN npm install -g gulp  
RUN npm install -g bower  
  
# Install gox and build the toolchain  
RUN go get github.com/mitchellh/gox  
RUN gox -build-toolchain  
RUN go get github.com/kisielk/errcheck  

