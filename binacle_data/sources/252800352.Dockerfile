FROM jboss/wildfly  
  
user root  
RUN yum install -y maven  
  
RUN mkdir -p /pdpsrc/src  
COPY ./pom.xml /pdpsrc/pom.xml  
RUN cd /pdpsrc && mvn dependency:tree  
COPY ./src/ /pdpsrc/src/  
RUN cd /pdpsrc/ && mvn clean install  
RUN cp /pdpsrc/target/pdp.war /opt/jboss/wildfly/standalone/deployments/ \  
&& chown jboss.jboss /opt/jboss/wildfly/standalone/deployments/pdp.war \  
&& rm -rf /pdpsrc  
  
user jboss  
EXPOSE 9763  

