FROM alpine  
MAINTAINER André Nishitani <atoshio25@gmail.com>  
RUN apk add \--no-cache curl build-base \  
&& curl -O https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz \  
&& mv cmake-3.7.2.tar.gz /tmp/ && cd /tmp \  
&& tar -xzf cmake-3.7.2.tar.gz \  
&& cd cmake-3.7.2 \  
&& sh bootstrap \  
&& make \  
&& make install \  
&& cd / && rm -r /tmp/cmake-3.7.2  

