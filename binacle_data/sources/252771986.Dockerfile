FROM jboss/wildfly  
USER root  
RUN mkdir /etc/nba  
ADD nba.properties /etc/nba/nba.properties  
ADD log4j2.xml /etc/nba/log4j2.xml  
ADD standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml  
COPY dwca /etc/nba/dwca  
ADD nba.war /opt/jboss/wildfly/standalone/deployments/  

