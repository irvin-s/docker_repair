FROM mysql:5.5  
MAINTAINER Azuki <support@azukiapp.com>  
  
COPY azk-entrypoint.sh /  
  
ENTRYPOINT ["/azk-entrypoint.sh"]  
  
CMD ["mysqld"]  

