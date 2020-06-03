FROM percona:latest  
MAINTAINER Frédéric T <xmedias@easycom.digital>  
  
ADD ./bashrc.root /root/.bashrc  
  
# =========================================  
# Update apt-cache and install basics  
# =========================================  
RUN DEBIAN_FRONTEND=noninteractive apt-get update \  
&& apt-get -y --no-install-recommends install nano \  
htop \  
iptraf \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

