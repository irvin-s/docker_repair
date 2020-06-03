FROM tomcat:8.0
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY .keystore /root/.keystore
COPY idp.xml /usr/local/tomcat/conf/Catalina/localhost/idp.xml
COPY shibboleth-idp /opt/shibboleth-idp/

RUN /opt/shibboleth-idp/bin/build.sh

EXPOSE 8080 8443
