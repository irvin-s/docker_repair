FROM quay.io/alfresco/alfresco-share:6.0

# Add DBP AMPs
#COPY target/amps /usr/local/tomcat/amps_share

#RUN java -jar /usr/local/tomcat/alfresco-mmt/alfresco-mmt*.jar install \
#        /usr/local/tomcat/amps_share /usr/local/tomcat/webapps/share -directory -nobackup
