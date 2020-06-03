FROM sonarqube:5.5  
MAINTAINER Andreas Marneris, <andreas.marneris>  
  
ENV SONARQUBE_PLUGINS_DIR=/opt/sonarqube/default/extensions/plugins \  
SONARQUBE_SERVER_BASE="http://localhost:9000" \  
SONARQUBE_WEB_CONTEXT="/sonar" \  
SONARQUBE_FORCE_AUTHENTICATION=true \  
ADOP_LDAP_ENABLED=true  
  
COPY resources/plugins.txt ${SONARQUBE_PLUGINS_DIR}/  
COPY resources/sonar.sh resources/plugins.sh /usr/local/bin/  
  
RUN chmod +x /usr/local/bin/*  
RUN /usr/local/bin/plugins.sh ${SONARQUBE_PLUGINS_DIR}/plugins.txt  
  
VOLUME ["/opt/sonarqube/logs/"]  
  
ENTRYPOINT ["/usr/local/bin/sonar.sh"]  

