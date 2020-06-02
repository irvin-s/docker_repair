FROM brumbrum/base  
MAINTAINER Alessandro Lattao <alessandro.lattao@brumbrum.it>  
  
# Installo i pacchetti base per python  
RUN \  
apt-get -y --no-install-recommends install rsyslog curl gnupg2 && \  
curl -sL https://deb.nodesource.com/setup_8.x | bash - && \  
apt-get install -y nodejs && \  
apt-get -y purge curl gnupg2 && \  
apt-get -y autoclean && \  
apt-get -y clean && \  
apt-get -y autoremove  
  
# Configuro rsyslog  
ADD etc/rsyslog.conf /etc/rsyslog.conf  
ADD etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf  
  
# riconfiguro l'entrypoint  
ADD bin/entrypoint.sh /entrypoint.sh  
RUN ["chmod", "+x", "/entrypoint.sh"]  
ENTRYPOINT ["/entrypoint.sh"]  

