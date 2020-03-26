from ubuntu-upstart:14.10  
MAINTAINER carlos.alberto@aexo.com.br  
  
RUN apt-get update  
  
RUN apt-get install -y guacamole-tomcat  
RUN apt-get install -y libguac-client-ssh0 libguac-client-rdp0  
  

