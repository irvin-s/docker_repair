FROM golang AS frpBuild  
  
ENV CGO_ENABLED=0  
ARG WORK=/go/src/github.com/fatedier  
  
RUN mkdir -p $WORK \  
&& cd $WORK \  
&& git clone -b master https://github.com/bingozb/frp.git \  
&& cd frp \  
&& make \  
&& cp bin/frps /frps \  
&& cp conf/frps.ini /frps.ini \  
&& make clean \  
&& rm -rf /go/src/*  
  
FROM alpine:3.7  
MAINTAINER bingo <bingov5@icloud.com>  
  
COPY \--from=frpBuild /frps /  
COPY \--from=frpBuild /frps.ini /  
  
EXPOSE 7000 7500 10080  
WORKDIR /  
CMD ["/frps", "-c", "frps.ini"]  

