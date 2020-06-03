FROM nginx  
  
MAINTAINER Simeon Ackermann <amseon@web.de>  
  
RUN apt-get update  
RUN apt-get install -y git  
  
ADD site.sh ./site.sh  
  
EXPOSE 80  
CMD ["/bin/bash", "./site.sh"]

