FROM ubuntu:trusty  
  
MAINTAINER blackbarn@gmail.com  
  
ENV LANG en_US.UTF-8  
RUN locale-gen $LANG  
  
RUN apt-get update -q && \  
apt-get install -qy git-core python2.7  
  
RUN git clone https://github.com/rembo10/headphones.git /headphones  
  
ADD start.sh /start.sh  
  
RUN chmod +x start.sh  
  
VOLUME ["/data"]  
EXPOSE 8181  
CMD ["/start.sh"]  
  

