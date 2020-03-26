FROM mysql:5.6  
# switch mysql user to root  
RUN sed -i "s/= mysql/= root/g" /etc/mysql/my.cnf  
  
# modified entrypoint  
COPY docker-entrypoint.sh /usr/local/bin/

