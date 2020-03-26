FROM docker-internal.blueriq.com/tomcat9-jdk11:1.0
LABEL maintainer="support@blueriq.com"

ARG BLUERIQ_LICENSE
ENV JAVA_OPTS="-Dspring.config.additional-location=file:///config/blueriq-runtime/ -Djava.security.egd=file:/dev/./urandom -Dlogging.file=runtime.log -Dblueriq.license=${BLUERIQ_LICENSE} -Xmx768m"
EXPOSE 8080

COPY blueriq-runtime-application-*.war /usr/local/tomcat/webapps/Runtime.war
ADD /config /config/blueriq-runtime/
