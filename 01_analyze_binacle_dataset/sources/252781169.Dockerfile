FROM debian:jessie  
  
MAINTAINER Pyrax <piranhadev@gmail.com>  
  
# SA-MP server executable is a x86 application only  
RUN dpkg --add-architecture i386  
  
# Install packages  
RUN apt-get update && apt-get install -y \  
lib32stdc++6 \  
wget \  
psmisc \  
nano \  
htop  
  
# Download server files  
RUN wget http://files.sa-mp.com/samp037svr_R2-1.tar.gz \  
&& tar xzf samp037svr_R2-1.tar.gz \  
&& rm -f samp037svr_R2-1.tar.gz \  
&& mkdir -p /home/server \  
&& mv /samp03 /home/server \  
&& cd /home/server \  
&& rm -rf include npcmodes/*.pwn filterscripts/*.pwn gamemodes/*.pwn \  
&& chmod 700 *  
  
COPY samp.sh /usr/local/bin/samp  
COPY docker-entrypoint.sh /entrypoint.sh  
  
RUN chmod +x /usr/local/bin/samp \  
&& chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["samp", "start"]  
  
EXPOSE 7777/udp  

