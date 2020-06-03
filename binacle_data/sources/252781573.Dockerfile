FROM golang:1.7.1  
MAINTAINER Barak Bar Orion <barak.bar@gmail.com>  
  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
RUN apt-get install -y git  
  
RUN curl https://glide.sh/get | sh  
  
RUN mkdir -p /golang/web-crawler/src/github.com/barakb  
WORKDIR /golang/web-crawler/src/github.com/barakb  
  
RUN git clone https://github.com/barakb/web-crawler.git  
  
WORKDIR /golang/web-crawler/src/github.com/barakb/web-crawler  
  
env PATH /golang/web-crawler/src/github.com/barakb/web-crawler:$PATH  
  
RUN glide install  
  
WORKDIR /golang/web-crawler  
  
COPY serve.sh /golang/web-crawler/  
  
ENTRYPOINT ["/golang/web-crawler/serve.sh"]  

