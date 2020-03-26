FROM postgres:9.3  
MAINTAINER Azuki <support@azukiapp.com>  
  
COPY azk-entrypoint.sh /  
  
ENTRYPOINT ["/azk-entrypoint.sh"]  
CMD ["postgres"]  

