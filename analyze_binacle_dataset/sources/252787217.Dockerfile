FROM daocloud.io/library/tomcat:8.5  
COPY keycloak-tomcat8-adapter/* /usr/local/tomcat/lib/  
COPY context.xml /usr/local/tomcat/conf  
  
RUN apt-get update && apt-get install -y vim && \  
rm -rf /var/lib/apt/lists/*  
  
ADD idsw.zip /tmp/  
WORKDIR /tmp  
RUN unzip idsw.zip -d idsw  
RUN mv idsw /usr/local/tomcat/webapps/ && \  
rm -rf idsw.zip && mkdir -p /data/idsw  
  

