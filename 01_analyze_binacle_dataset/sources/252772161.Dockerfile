FROM rabbitmq:3.6.11  
MAINTAINER Eli Ribble <eli@authentise.com>  
COPY docker-entrypoint-hooks.sh /usr/local/bin  
COPY on-startup.sh /hooks/on-startup.sh  
ENTRYPOINT ["docker-entrypoint-hooks.sh"]  
EXPOSE 4369 5671 5672 25672  

