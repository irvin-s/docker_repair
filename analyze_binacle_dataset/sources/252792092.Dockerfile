FROM ubuntu:16.04  
  
RUN \  
apt-get update \  
&& apt-get install -y letsencrypt apache2-utils \  
&& mkdir -p /azure_certs \  
&& mkdir -p /azure_auth \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80 443

