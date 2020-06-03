FROM mariadb:10.1  
VOLUME /var/lib/mysql/  
  
RUN mkdir /galera  
RUN mkdir /galera/ssl  
ADD galera.cnf.tpl /galera/  
ADD run.sh /galera/  
  
RUN chmod +x /galera/run.sh  
  
ENTRYPOINT [ "/galera/run.sh" ]  
CMD [ "mysqld" ]  

