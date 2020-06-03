FROM densuke/ubuntu-supervisor  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -qq update  
RUN apt-get -yqq upgrade  
RUN apt-get -yqq install ngircd  
  
ADD ngircd.conf /etc/ngircd/ngircd.conf  
ADD ngircd.motd /etc/ngircd/ngircd.motd  
  
ADD supervisord.conf /etc/supervisord.d/ngircd.ini  
  
EXPOSE 6667  
  
CMD ["/usr/local/bin/supervisord", "-n"]  
  

