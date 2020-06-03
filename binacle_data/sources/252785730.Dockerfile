FROM debian  
MAINTAINER comphilip@msn.com  
  
RUN apt-get update \  
&& apt-get install -y openvpn \  
&& rm -rf /var/lib/apt/lists/*  

