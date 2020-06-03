FROM cassandra:2.1  
MAINTAINER Alexandru Rosianu <me@aluxian.com>  
  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["cassandra", "-f"]  

