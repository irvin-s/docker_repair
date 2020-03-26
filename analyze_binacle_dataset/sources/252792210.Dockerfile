FROM alpine  
MAINTAINER Simone Esposito <chaufnet@gmail.com>  
  
RUN apk add \--no-cache znc  
  
USER znc  
VOLUME ["/home/znc/.znc"]  
CMD ["znc", "--foreground"]  

