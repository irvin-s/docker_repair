FROM nginx:1.11.10  
MAINTAINER Davide Zeri <zeridavide@gmail.com>  
  
COPY run.sh /etc/utils/  
CMD ["sh", "/etc/utils/run.sh"]  

