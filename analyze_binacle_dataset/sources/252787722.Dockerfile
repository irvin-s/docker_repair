FROM redis:latest  
MAINTAINER Elliot Morales <elliot@brutalsys.com>  
  
ENV TERM xterm  
ENV MASTER_IP ""  
ENV MASTER_PORT 6379  
ENV EVALUATE_MASTER_IP false  
ENV EVALUATE_MASTER_PORT false  
ADD ./start.sh /start.sh  
RUN chmod +x /start.sh  
CMD ["/bin/bash", "/start.sh"]

