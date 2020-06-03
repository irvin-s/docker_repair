FROM ubuntu:xenial  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get upgrade -q -y \  
&& apt-get dist-upgrade -q -y \  
&& apt-get install -q -y wget curl \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& cd /tmp \  
&& wget https://www.multichain.com/download/multichain-2.0-alpha-2.tar.gz \  
&& tar -xvzf multichain-2.0-alpha-2.tar.gz \  
&& cd multichain-2.0-alpha-2 \  
&& mv multichaind multichain-cli multichain-util /usr/local/bin \  
&& cd /tmp \  
&& rm -Rf multichain*  
  
CMD ["/bin/bash"]  

