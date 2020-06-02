FROM ubuntu  
  
RUN apt-get update -y  
RUN apt-get install -y --force-yes git-core wget make bzr  
  
#golang  
RUN wget --quiet https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz && \  
tar -C /usr/local -xzf go1.2.linux-amd64.tar.gz  
ENV GOPATH /gopath  
ENV PATH $PATH:$GOPATH/bin:/usr/local/go/bin  
  
ADD . /gopath/src/github.com/AndrewVos/github-authentication-proxy  
WORKDIR /gopath/src/github.com/AndrewVos/github-authentication-proxy  
RUN go get  
RUN go build  

