FROM ubuntu:latest  
  
MAINTAINER Benoit Theunissen <benoit.theunissen@gmail.com>  
  
RUN apt-get update && apt-get -y install nano cron gettext mutt at curl wget  
  
WORKDIR /opt/upchecker  
  
RUN touch /var/log/cron.log  
  
CMD /opt/upchecker/run.sh  
  
ADD crontab /opt  
  
ADD muttrc /opt  
  
ADD setenv.sh /opt  
  
ADD run.sh /opt/upchecker  
  
ADD upchecker.sh /opt/upchecker  

