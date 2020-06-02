FROM golang:1.9-alpine  
  
MAINTAINER Sonny <bernhardkohler@icloud.com>  
  
RUN apk add --update --no-cache \  
bash \  
git \  
make \  
ca-certificates  
  
ENV DEX_GIT_BRANCH v2.7.1  
RUN git clone \--depth 1 --branch $DEX_GIT_BRANCH \  
https://github.com/coreos/dex.git $GOPATH/src/github.com/coreos/dex \  
&& cd $GOPATH/src/github.com/coreos/dex \  
&& make bin/example-app \  
&& cp bin/example-app /usr/local/bin/  
  
EXPOSE 5555  
ADD entrypoint.sh /entrypoint.sh  
  
CMD ["/entrypoint.sh"]  

