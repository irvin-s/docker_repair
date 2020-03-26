FROM library/debian:stretch  
  
MAINTAINER kenneth@floss.cat  
  
RUN apt-get update && \  
apt-get -y upgrade && \  
apt-get -y install apache2  
  
# ADD / COPY  
# CMD  
# ENTRYPOINT  
  
EXPOSE 80 443  
  
ENTRYPOINT ["apachectl","-D","FOREGROUND"]  
  

