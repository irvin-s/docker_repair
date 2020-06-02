FROM cmfatih/phantomjs  
MAINTAINER edvakf@pixiv.com  
RUN \  
apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y fonts-ipaexfont-gothic && \  
apt-get autoremove -y && \  
apt-get clean all  
ENTRYPOINT ["/usr/bin/phantomjs"]  
CMD ["--help"]  

