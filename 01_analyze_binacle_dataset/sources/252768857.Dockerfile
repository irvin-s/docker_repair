FROM ubuntu:trusty  
  
MAINTAINER Andrew Buss  
  
RUN apt-get -qq update --fix-missing  
RUN locale-gen en_US en_US.UTF-8  
RUN dpkg-reconfigure locales  
  
RUN apt-get install -y bash mpd  
  
ADD mpd.conf /etc/mpd.conf  
ADD start.sh /home/mpd/start.sh  
  
RUN mkdir /mpd  
RUN chown mpd /mpd  
RUN chmod +x /home/mpd/start.sh  
  
EXPOSE 6600  
ENTRYPOINT /home/mpd/start.sh  

