FROM jenkinsci/jenkins:2.60.3  
USER root  
RUN mkdir /var/log/jenkins  
RUN mkdir /var/cache/jenkins  
RUN chown -R jenkins:jenkins /var/log/jenkins  
RUN chown -R jenkins:jenkins /var/cache/jenkins  
USER jenkins  
ENV JAVA_OPTS="-Xmx1024m"  

