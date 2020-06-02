FROM crux/base:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
RUN ports -u && prt-get cache  
RUN prt-get depinst gtk  
RUN prt-get depinst xorg-font-alias  
RUN prt-get depinst xorg-font-misc-misc  
RUN prt-get depinst xorg-font-bitstream-vera  
  
RUN prt-get depinst xorg-font-bh-ttf  
RUN prt-get depinst xorg-font-dejavu-ttf  
RUN prt-get depinst xorg-font-inconsolata-dz  
  
ENV DISPLAY=:0.0  
  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

