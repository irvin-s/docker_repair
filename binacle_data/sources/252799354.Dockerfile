FROM debian:stretch-slim  
  
ENV GAME_TYPE ctf  
  
RUN apt-get update \  
&& apt-get install -y teeworlds-server pwgen wget \  
&& apt-get clean all  
  
COPY * /  
  
RUN chmod +x /run.sh /stdoutprocessor.sh  
  
EXPOSE 8303/udp  
CMD ["/run.sh"]  

