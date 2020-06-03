FROM openshift/jenkins-slave-maven-centos7  
  
LABEL maintainer="Arnaud Deprez <arnaudeprez@gmail.com>"  
  
USER root  
  
ADD ./contrib/init.gradle $HOME/.gradle/  
  
RUN chown -R 1001:0 $HOME && \  
chmod -R g+rw $HOME  
  
USER 1001  

