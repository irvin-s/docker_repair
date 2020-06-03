FROM stdutil/env:0.0.1

MAINTAINER StdUtil

WORKDIR /

ARG JAR_FILE

COPY target/${JAR_FILE} /usr/local/tomcat/webapps/blog.war
COPY docker/run.sh /
COPY docker/server.xml /usr/local/tomcat/conf/

EXPOSE 80

CMD ["bash","run.sh"]

