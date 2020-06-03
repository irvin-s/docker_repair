FROM colstrom/ubuntu-core  
  
# libsodium  
RUN add-apt-repository --yes ppa:xuzhen666/dnscrypt \  
&& apt-get update \  
&& apt-get --assume-yes install libsodium13 libsodium-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
# zeromq  
RUN add-apt-repository --yes ppa:chris-lea/zeromq \  
&& apt-get update \  
&& apt-get --assume-yes install libzmq3 libzmq3-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

