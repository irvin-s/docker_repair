FROM openjdk:7  
MAINTAINER Darwin Monroy <contact@darwinmonroy.com>  
  
WORKDIR /usr/src  
  
RUN curl -L -o saiku-latest.zip \  
http://www.meteorite.bi/downloads/saiku-latest.zip \  
&& unzip saiku-latest.zip \  
&& rm -f saiku-latest.zip  
  
EXPOSE 8080  
CMD /usr/src/saiku-server/start-saiku.sh \  
&& tail -f /usr/src/saiku-server/tomcat/logs/catalina.out  

