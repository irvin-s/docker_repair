FROM ceagan/wildfly:9.0.2.Final  
  
# Add custom scripts and modules for configuration and startup  
ADD customization /opt/jboss/wildfly/customization/  
ADD modules /opt/jboss/wildfly/modules/  
  
# Switch to root user for software installation and starting services  
USER root  
  
RUN chmod +x /opt/jboss/wildfly/customization/*.sh && \  
chown -R jboss:jboss /opt/jboss/wildfly  
  
# The official widlfly instance is supposed to include xmlstarlet. These  
# commands install it, but we are currently using the ceagan/wildfly image  
# instead of the official one in order to include xmlstarlet.  
# yum install -y epel-release  
# yum install -y xmlstarlet  
USER jboss  
# Switch to jboss user for execution  
# Perform configuration of the jboss  
RUN /opt/jboss/wildfly/customization/execute.sh  
  
# Install the application war file  
ADD web.rya.war /opt/jboss/wildfly/standalone/deployments/  
  
# Set a custom startup command for the image  
CMD ["/opt/jboss/wildfly/customization/startup.sh"]  

