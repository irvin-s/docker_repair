FROM alpine:3.4  
MAINTAINER Akshay Kapoor <akshaykapoor@crowdfireapp.com>  
  
ENV VERSION=5.1.1  
RUN apk --update add python py-setuptools py-pip && \  
pip install elasticsearch-curator==${VERSION} && \  
apk del py-pip && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["/usr/bin/curator"]  
  

