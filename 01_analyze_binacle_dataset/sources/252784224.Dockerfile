FROM sonarqube:6.3.1  
  
RUN groupadd -g 1000 sonar \  
&& useradd -d "$SONARQUBE_HOME" -u 1000 -g sonar -m -s /bin/bash sonar \  
&& chown -R sonar:sonar "$SONARQUBE_HOME"  
  
EXPOSE 9000  
VOLUME "$SONARQUBE_HOME/data"  
USER sonar  
  

