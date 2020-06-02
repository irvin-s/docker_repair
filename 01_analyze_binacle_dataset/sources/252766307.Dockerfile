FROM alpine  
MAINTAINER Abhijeet Kamble (abhijeet.kamble619@gmail.com)  
  
ENV EMAIL example@example.com  
  
RUN mkdir -p /etc/alertmanager/  
ADD ./alertmanager.yml /etc/alertmanager/  
  
ADD ./run.sh /etc/alertmanager/  
RUN chmod 777 /etc/alertmanager/run.sh  
  
ENTRYPOINT ["/bin/sh","/etc/alertmanager/run.sh"]  
  

