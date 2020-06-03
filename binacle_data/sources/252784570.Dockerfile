FROM ubuntu:latest  
MAINTAINER bkvaluemeal <sirJustin.Willis@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -y \  
software-properties-common \  
&& add-apt-repository ppa:bitcoin/bitcoin \  
&& apt-get update \  
&& apt-get install -y \  
supervisor \  
bitcoind  
  
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
EXPOSE 8332 8333 18332 18333  
  
CMD ["/usr/bin/supervisord"]  

