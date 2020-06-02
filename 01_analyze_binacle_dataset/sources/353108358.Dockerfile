FROM tomcat:9.0.10-jre8-alpine
COPY demo-server/ ${CATALINA_HOME}/
COPY */target/*.war ${CATALINA_HOME}/webapps/
RUN ln -s ${CATALINA_HOME}/webapps/$(basename ${CATALINA_HOME}/webapps/demo-flow-components-*.war .war) ${CATALINA_HOME}/webapps/components
