FROM ubuntu:latest  
  
MAINTAINER Doğan Aydın <dogan1aydin@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y git-core lib32gcc1 screen wget  
RUN mkdir ~/cs16 ; cd ~/cs16  
RUN wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz  
RUN tar -xvzf steamcmd_linux.tar.gz  
  
EXPOSE 27015 27015  
EXPOSE 27039 27039  
EXPOSE 1200/udp 1200/udp  
EXPOSE 27000/udp 27000/udp  
EXPOSE 27015/udp 27015/udp  

