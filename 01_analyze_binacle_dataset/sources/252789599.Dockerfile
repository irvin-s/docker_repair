FROM dustin/r-studio-base  
MAINTAINER Dustin Sallings "dustin@spy.net"  
  
ENV LOCALE UTF-8 LC_ALL UTF-8  
  
EXPOSE 8787  
  
CMD /usr/lib/rstudio-server/bin/rserver \--server-daemonize 0  

