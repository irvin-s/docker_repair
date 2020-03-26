FROM 1and1internet/ubuntu-16:latest  
MAINTAINER lee.harrison@1and1.co.uk  
  
RUN \  
apt-get update && \  
apt-get install -y collectd curl tcpdump wget vim telnet && \  
rm -rf /var/lib/apt/lists/*  
RUN \  
rm -rf /etc/collectd/collectd.conf.d/*  
  
COPY files /  

