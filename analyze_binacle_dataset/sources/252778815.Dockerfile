# FROM ubuntu:14.04  
FROM phusion/baseimage  
EXPOSE 5683  
ADD ws_sync0 bin/  
RUN chmod -R 777 bin  
CMD ["bin/ws_sync0"]

