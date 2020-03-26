FROM sonarqube:6.7.3  
ENV SONAR_DOWNLOAD_URL https://sonarsource.bintray.com/Distribution  
  
COPY sonar.properties /opt/sonarqube/conf/sonar.properties  
ADD start_with_plugins.sh /opt/sonarqube/start_with_plugins.sh  
ENTRYPOINT ["/opt/sonarqube/start_with_plugins.sh"]  

