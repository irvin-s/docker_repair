##  
## ВНИМАНИЕ! Этот файл создаётся сценарием "update.sh".  
## Не меняйте его вручную — он будет перезаписан.  
##  
FROM mysql:5.6  
COPY docker-mysql-* /usr/local/bin/  
  
ENTRYPOINT ["docker-mysql-start"]  
CMD ["mysqld"]  

