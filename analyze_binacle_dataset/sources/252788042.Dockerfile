FROM crazybit/bitshares-2  
MAINTAINER crazybit <crazybit.github@gmail.com>  
  
## Copying default configuration  
RUN mkdir /.Bitshares2  
ADD docker/start.sh /start.sh  
RUN chmod a+x /start.sh  
  
## Exposing Ports  
EXPOSE 9090  
EXPOSE 8090  
## Entry point  
ENTRYPOINT ["/start.sh"]  

