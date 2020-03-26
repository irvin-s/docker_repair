FROM ubuntu:18.04  
MAINTAINER andyzhshg <andyzhshg@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y curl cron  
RUN curl https://get.acme.sh | sh  
  
ADD entry.sh /  
  
CMD ["/entry.sh"]  
  

