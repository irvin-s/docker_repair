FROM ubuntu:14.04 

RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/cwahl-Treeptik/jdev-env-java/releases/download/v0.1/tomcat-bin.tar && tar -xvf tomcat-bin.tar && rm tomcat-bin.tar
RUN wget https://github.com/cwahl-Treeptik/jdev-env-java/releases/download/v0.1/helloworld.war -O /tomcat-bin/webapps/helloworld.war

VOLUME /tomcat-bin
