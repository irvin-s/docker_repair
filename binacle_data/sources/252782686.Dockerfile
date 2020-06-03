FROM uchiwa/uchiwa:0.22.1  
MAINTAINER Brice Argenson <brice@clevertoday.com>  
  
COPY config.json /config/config.json  
COPY docker-entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["start"]

