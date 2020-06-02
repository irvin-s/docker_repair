FROM dariksde/ubuntu-baseimage:17.10  
MAINTAINER Daniel Rippen <rippendaniel@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install -y apache2 && \  
apt-get clean  
  
RUN rm -rf /var/lib/apt/lists/*  
  
ADD start.sh /start.sh  
  
CMD ["/bin/bash", "/start.sh"]  

