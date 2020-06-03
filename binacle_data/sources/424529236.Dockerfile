FROM tomcat:8.5.4
ENV JAVA_OPTS='-Ddb.env=mysql-container'
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY ./affablebean-web/target/affablebean-web-*.war /usr/local/tomcat/webapps/ROOT.war