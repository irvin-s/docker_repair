FROM jboss/wildfly  
  
MAINTAINER dolphindev <oze@digital-globe.co.jp>  
  
ADD modules /opt/jboss/wildfly/modules/  
  
ADD standalone-dolphin.xml /opt/jboss/wildfly/standalone/configuration/  
  
ADD opendolphin-server-2.7.0.war /opt/jboss/wildfly/standalone/deployments/  
  
ADD custom.properties /opt/jboss/wildfly/  
  
ADD templates /opt/jboss/wildfly/templates  
  
ADD docker-entrypoint.sh /opt/jboss/wildfly/  
  
ENTRYPOINT [ "/opt/jboss/wildfly/docker-entrypoint.sh" ]  
  
CMD [ "0.0.0.0" ]  

