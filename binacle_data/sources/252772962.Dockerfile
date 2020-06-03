FROM alpine:3.4  
MAINTAINER Stephan Straubel <straubel@bestit-online.de>  
  
VOLUME [ "/opt/logs" ]  
  
COPY run.sh /run.sh  
RUN chmod +x /run.sh  
  
CMD [ "/run.sh" ]  

