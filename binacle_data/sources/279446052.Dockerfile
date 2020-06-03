FROM jfrogtraining-docker-dev.jfrog.io/tomcat:8.0.44-jre8-alpine

MAINTAINER ankushc@jfrog.com

ARG WEB_APPLICATION_NAME

COPY $WEB_APPLICATION_NAME .

RUN rm -fr webapps/ROOT/ && cp $WEB_APPLICATION_NAME webapps/

CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

