FROM python:2.7  
MAINTAINER cowpanda<ynw506@gmail.com>  
COPY start.app /start.app  
RUN chmod 755 /start.app  
VOLUME ["/app"]  
WORKDIR /app  
  
CMD ["/start.app"]  

