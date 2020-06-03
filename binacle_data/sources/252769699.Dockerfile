FROM alpine:latest  
  
# Install basic dependencies  
RUN apk update && apk add \  
gcc \  
g++ \  
make \  
libev \  
libev-dev \  
libconfig \  
libconfig-dev  
  
COPY . /usr/src/statsd-aggregator/  
  
RUN cd /usr/src/statsd-aggregator \  
&& make  
  
WORKDIR /usr/src/statsd-aggregator  
  
ENTRYPOINT ["./statsd-aggregator", "-c", "/etc/aggregator.cfg"]  

