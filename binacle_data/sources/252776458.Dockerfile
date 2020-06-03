FROM debian:wheezy-slim  
  
MAINTAINER oh@bootjp.me  
  
RUN apt-get update && apt-get -y install gcc git libssl-dev make && \  
cd /tmp && git clone https://github.com/wg/wrk.git && cd wrk/ && \  
make && cp wrk /usr/local/bin/ && rm -rf /tmp/wrk && \  
apt-get -y remove gcc git libssl-dev make  
  
CMD ["wrk"]  

