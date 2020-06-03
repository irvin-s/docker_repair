FROM java:8  
MAINTAINER drome1  
  
COPY start.sh /start.sh  
COPY event-publisher-api.war /event-publisher-api.war  
COPY source.txt /camel/data/source.txt  
CMD ["/start.sh"]

