FROM mysql:5.7  
  
RUN \  
apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y python2.7 htop && \  
apt-get autoremove -y && \  
apt-get autoclean -y && \  
rm -rf /tmp/* /var/lib/apt/lists/* && \  
true  
  
ADD sqldump/ /sqldump/  

