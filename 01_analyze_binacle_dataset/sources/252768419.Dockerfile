FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y libmariadb2 netcat && apt-get clean  
ADD ts3 /opt/ts3  
ADD start.sh /start.sh  
  
EXPOSE 9987/udp 30033 10011  
CMD ["/start.sh"]  

