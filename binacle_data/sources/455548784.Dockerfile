FROM spire-agent

# Install Front-end application and configure Tomcat
RUN rm -Rf /opt/tomcat/webapps/ROOT*
COPY tasks-app-1.0.war /opt/tomcat/webapps/ROOT.war
COPY server.xml /opt/tomcat/conf/server.xml

RUN mkdir /opt/front-end
COPY start-tomcat.sh /opt/front-end
RUN chmod +x /opt/front-end/start-tomcat.sh
COPY frontend.security /opt/front-end

RUN mkdir /opt/sslCurl
COPY sslCurl.jar /opt/sslCurl
COPY curl.security /opt/sslCurl
COPY sslCurl.sh /opt/sslCurl
RUN chmod +x /opt/sslCurl/sslCurl.sh

#Create users for frontend workloads
RUN useradd frontend1 -u 1000
RUN useradd frontend2 -u 1001
RUN useradd frontend3 -u 1002

RUN chown -R frontend1 /opt/tomcat
