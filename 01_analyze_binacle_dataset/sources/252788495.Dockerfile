FROM crux/gtk:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
CMD ["/usr/bin/xchat"]  
  
RUN prt-get depinst xchat  

