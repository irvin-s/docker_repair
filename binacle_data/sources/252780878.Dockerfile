FROM alpine  
  
MAINTAINER Coroin LLC <info@coroin.com>  
  
RUN apk --no-cache add git yarn \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["yarn"]

