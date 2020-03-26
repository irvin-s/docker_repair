FROM breakyboy/ghost-utils:0.6.2  
MAINTAINER Andres Rojas <andres@conpat.io>  
ENV REFRESHED_AT 2015-05-04  
VOLUME /backup  
  
COPY backup.sh backup  
RUN chmod +x backup  
  
CMD ["./backup"]  

