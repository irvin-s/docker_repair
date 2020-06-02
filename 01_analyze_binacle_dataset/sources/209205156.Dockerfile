FROM seshagirisriram/tomcat8
MAINTAINER Seshagiri Sriram <seshagirisriram@gmail.com>

COPY addressbook.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
