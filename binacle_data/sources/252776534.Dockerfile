FROM datadog/agent:6.1.4  
RUN apt-get update  
RUN mv /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.bak  
RUN apt-get install -y git  
RUN mv /etc/ssl/openssl.cnf.bak /etc/ssl/openssl.cnf  
  
COPY ./start.sh /start.sh  
RUN chmod 755 /start.sh  
  
WORKDIR /  
  
CMD ["/start.sh"]

