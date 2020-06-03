FROM tomcat:8-jre8  
  
MAINTAINER kim@conduct.no  
ENV CATALINA_HOME /usr/local/tomcat  
ENV PATH $CATALINA_HOME/bin:$PATH  
WORKDIR $CATALINA_HOME  
  
EXPOSE 8080  
# download openam nightly build war  
# Trick taken from wadahiro/docker-openam-nightly!  
ADD run-openam.sh /tmp/run-openam.sh  
  
CMD ["/tmp/run-openam.sh"]  

