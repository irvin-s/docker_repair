FROM codingtony/java

MAINTAINER tony.bussieres@ticksmith.com

RUN apt-get update
RUN apt-get upgrade -y
RUN wget http://apache.mirror.rafal.ca/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz
RUN echo "3c46fc0f608c1280dcd65100a983f285  /apache-tomcat-7.0.55.tar.gz" | md5sum -c
RUN cd /opt && tar xvf ~/apache-tomcat-7.0.55.tar.gz
RUN mv /opt/apache-tomcat-7.0.55 /opt/tomcat
RUN rm ~/apache-tomcat-7.0.55.tar.gz

EXPOSE 8080

CMD [ "/opt/tomcat/bin/catalina.sh","run" ]

