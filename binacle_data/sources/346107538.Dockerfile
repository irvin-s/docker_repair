FROM kohsuke/acmecorp-base

COPY target/test-webapp.war /usr/local/tomcat/webapps/ROOT.war
RUN rm -rf /usr/local/tomcat/webapps/ROOT

