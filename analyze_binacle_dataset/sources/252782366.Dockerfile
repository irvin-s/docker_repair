FROM alpine:3.5  
MAINTAINER Dario Civallero <dario.civallero@gmail.com>  
  
ENV LANG C.UTF-8  
# Install software  
RUN apk add --update ffmpeg gifsicle imagemagick bc  
  
# mount /data  
WORKDIR /data  
  
# entry point script  
COPY entrypoint.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/entrypoint.sh  
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]  

