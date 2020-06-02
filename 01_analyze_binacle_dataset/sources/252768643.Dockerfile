FROM haproxy:1.6.8  
MAINTAINER Anas ASO <aso.anas@protonmail.com>  
  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
  
RUN useradd haproxy && \  
chmod 755 /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

