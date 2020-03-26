FROM michaelhuettermann/infra
LABEL maintainer "michael@huettermann.net"
ARG ARTI

RUN apt-get -y update

# Install curl
RUN apt-get -y install curl=7.35.0-1ubuntu2.10

# Install tomcat
RUN apt-get -y install tomcat7=7.0.52-1ubuntu0.10
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7

ADD https://${ARTI}/list/libs-release-local/com/huettermann/web/1.0.0/all-1.0.0.war /var/lib/tomcat7/webapps/all.war

RUN chmod 755 /var/lib/tomcat7/webapps/*.war

ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

EXPOSE 8080

CMD ["/root/run.sh"]
 
