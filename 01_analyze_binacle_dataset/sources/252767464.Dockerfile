FROM alfaluck/mq-base:latest  
  
COPY ./dispatcher /usr/src/dispatcher  
COPY ./run /usr/local/bin  
RUN chmod +x /usr/local/bin/run  
WORKDIR /usr/src/dispatcher  
  
ENV redis_host localhost  
ENV redis_port 6379  
ENV redis_connection_timeout 3.5  
ENV redis_key_prefix main_queue:  
ENV redis_auth null  
ENV redis_database 0  
ENV redis_expire 600  
ENV mysql_host localhost  
ENV mysql_username root  
ENV mysql_password null  
ENV mysql_db_name test  
ENV mysql_port 3306  
ENV mailer_host smtp.sparkpostmail.com  
ENV mailer_port 587  
ENV mailer_secure tls  
ENV mailer_auth true  
ENV mailer_username SMTP_Injection  
ENV mailer_password test_api_key  
  
CMD ["run"]

