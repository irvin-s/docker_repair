FROM akohlbecker/base:latest  
  
RUN set -x && \  
apt-get --quiet --yes update && \  
apt-get --quiet --yes install letsencrypt && \  
apt-get -y autoremove && \  
apt-get -y clean && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /tmp/*  
  
CMD /bin/bash  

