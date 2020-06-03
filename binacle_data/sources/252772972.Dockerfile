FROM docker.bintray.io/jfrog/artifactory-pro:latest  
LABEL maintainer='Peter Wu <piterwu@outlook.com>'  
  
RUN rm -rf /opt/jfrog/artifactory/tomcat/webapps/ROOT \  
/opt/jfrog/artifactory/tomcat/conf/Catalina/localhost/artifactory.xml  
COPY ROOT.xml /opt/jfrog/artifactory/tomcat/conf/Catalina/localhost  
  
EXPOSE 8081

