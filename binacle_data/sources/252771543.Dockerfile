FROM ubuntu:16.04  
MAINTAINER Arnaud de Mouhy <arnaud.demouhy@akerbis.com>  
  
ENV STREAM "http://stream.morow.com:8080/morow_hi.aacp"  
ENV OUTPUT_DIRECTORY "/usr/share/nginx/html"  
ENV FORMAT "aac"  
ENV PLAYLIST_NAME "morow"  
ENV BITRATES "32:64:128"  
ADD rootfs/image_setup /image_setup  
RUN /bin/bash /image_setup/build.sh && rm -rf /image_setup  
ADD shoutcast2hls.sh /  
  
CMD ["bash", "/entrypoint.sh"]  

