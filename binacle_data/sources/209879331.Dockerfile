# Using centos 7 image
FROM tomcat:8-jre8
MAINTAINER ambud_sharma@symantec.com

RUN mkdir -p /opt/hendrix
RUN rm -rf /usr/local/tomcat/webapps/*

ADD ./ROOT.war /usr/local/tomcat/webapps/ROOT.war
ADD ./template.properties /opt/hendrix/
ADD ./run.sh /opt/hendrix/

RUN apt-get -y update
RUN apt-get -y --force-yes install gettext telnet

RUN chmod +x /opt/hendrix/run.sh
CMD /opt/hendrix/run.sh