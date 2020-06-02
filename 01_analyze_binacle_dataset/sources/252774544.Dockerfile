FROM analogic/cacti  
MAINTAINER info@analogic.cz  
  
ADD http://docs.cacti.net/_media/plugin:settings-v0.71-1.tgz /tmp/settings.tgz  
ADD http://docs.cacti.net/_media/plugin:thold-v0.5.0.tgz /tmp/thold.tgz  
  
RUN cd /tmp && \  
tar xvf settings.tgz && \  
tar xvf thold.tgz && \  
rm settings.tgz thold.tgz && \  
mv settings /usr/share/cacti/site/plugins && \  
mv thold /usr/share/cacti/site/plugins  
  

