FROM bitshares/bitshares-2  
MAINTAINER crazybit <crazybit.github@gmail.com>  
  
## Copying default configuration  
RUN mkdir /data_delayed_node  
ADD docker/start.sh /start.sh  
RUN chmod a+x /start.sh  
  
## Exposing Ports  
EXPOSE 8091  
## Entry point  
ENTRYPOINT ["/start.sh"]  

