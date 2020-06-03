FROM php  
  
MAINTAINER Christopher A. Mosher <cmosher01@gmail.com>  
  
USER root  
ENV HOME /root  
WORKDIR $HOME  
  
COPY ./src ./  
  
CMD [ "php", "--server", "0.0.0.0:80" ]  

