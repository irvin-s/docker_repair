FROM dockerfile/java:oracle-java8

MAINTAINER Ken Sipe <ken@mesosphere.io>

RUN echo "deb http://security.ubuntu.com/ubuntu precise-security main universe" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install tomcat7

#Remove the default container
RUN rm -rf /var/lib/tomcat7/webapps/ROOT /var/lib/tomcat7/webapps/ROOT.war

EXPOSE 8080

CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out

# 	ENTRYPOINT [‘executable’, ‘param1’,’param2’]