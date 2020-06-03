FROM quay.io/alfresco/alfresco-content-services:feature-AUTH-85-token-auth-6.0.0-IDENTITY-SERVICE-SNAPSHOT

# Add DBP AMPs
#COPY target/amps /usr/local/tomcat/amps

#RUN java -jar /usr/local/tomcat/alfresco-mmt/alfresco-mmt*.jar install \
#        /usr/local/tomcat/amps /usr/local/tomcat/webapps/alfresco -directory -nobackup
