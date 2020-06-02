FROM crux/base:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
ENV GOROOT /usr/lib/go  
ENV PATH $PATH:$GOROOT/bin  
  
RUN ports -u && \  
prt-get cache && \  
prt-get depinst go && \  
rm -rf /usr/ports/*  

