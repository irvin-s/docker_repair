FROM nginx:latest  
MAINTAINER Avni Rexhepi <arexhepi@gmail.com>  
  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm  
  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY start-container /usr/local/bin/start-container  
RUN chmod +x /usr/local/bin/start-container  
  
EXPOSE 80 443  
CMD ["start-container"]

