FROM mono:latest  
  
# RUN apt-get update && apt-get dist-upgrade -y  
# RUN apt-get -qqy install wget  
COPY startup.sh /  
RUN chmod +x startup.sh  
RUN mkdir /NodeLink  
  
VOLUME /NodeLink  
  
ENTRYPOINT ["/startup.sh"]  

