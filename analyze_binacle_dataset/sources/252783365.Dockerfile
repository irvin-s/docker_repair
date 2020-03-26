FROM debian:8.9  
MAINTAINER admin <evgeniy@kolesnyk.ru>  
RUN export DEBIAN_FRONTEND="noninteractive"  
RUN apt-get update -y  
RUN apt-get upgrade -y  
RUN apt-get install -y expect  
  
COPY setup-mysql.sh /root/setup-mysql.sh  
RUN chmod +x /root/setup-mysql.sh  
RUN /root/setup-mysql.sh  
  
EXPOSE 3306  

