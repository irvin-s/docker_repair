# cloudfleet mailpile  
#  
# VERSION 0.1  
FROM cloudfleet/mailpile  
  
  
VOLUME /opt/cloudfleet/Mails  
  
ADD . /opt/cloudfleet/setup  
  
  
USER root  
RUN apt-get update && apt-get install patch -y  
  
RUN /opt/cloudfleet/setup/scripts/patch.sh  
  
  
ENV USER=mailpile  
  
CMD /opt/cloudfleet/setup/scripts/start-debug.sh  

