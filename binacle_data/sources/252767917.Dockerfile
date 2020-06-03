FROM debian:jessie  
  
RUN apt-get update \  
&& apt-get install -y nmap \  
&& rm -rf /var/lib/apt/lists/*  
  
ADD http://nmap.org/svn/scripts/ssl-poodle.nse /usr/share/nmap/scripts/  
  
WORKDIR /root  
  
CMD ["nmap"]  

