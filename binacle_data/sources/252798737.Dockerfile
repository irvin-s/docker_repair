FROM desiato/jenkins-gradle  
  
USER root  
RUN mkdir -p /html \  
&& chown -R jenkins: /html  
  
VOLUME /html  
  
USER jenkins  
RUN /usr/local/bin/install-plugins.sh htmlpublisher  

