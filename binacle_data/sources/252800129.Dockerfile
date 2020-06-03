FROM jenkins:2.7.2  
#AVOID_CACHE  
RUN touch /tmp/1486221943  
#AVOID_CACHE_END  
COPY plugins.txt /usr/share/jenkins/ref/  
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt  
  

