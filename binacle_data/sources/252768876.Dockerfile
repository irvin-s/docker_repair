FROM busybox  
MAINTAINER Andrew Gorton (http://andrewgorton.uk)  
RUN mkdir -p /var/jenkins_home  
USER root  
RUN chown -R 1000 /var/jenkins_home  
VOLUME /var/jenkins_home  
CMD ["true"]  
  

