FROM debian:wheezy-slim  
  
MAINTAINER Chet Printhong  
  
RUN dpkg --add-architecture i386 \  
&& apt-get update && apt-get install libstdc++5:i386 wget -y \  
&& mkdir /app \  
&& wget http://download.sopcast.com/download/sp-auth.tgz -P /app \  
&& apt-get purge wget -y \  
&& apt-get autoremove -y  
  
WORKDIR /app  
RUN tar -xf sp-auth.tgz  
  
ADD docker-entrypoint.sh /  
  
EXPOSE 8902  
ENTRYPOINT ["/docker-entrypoint.sh"]  

