FROM busybox  
  
MAINTAINER Danilo Recchia <danilo@deltatecnologia.com>  
  
ENV HOST_COMMAND_ON_START docker start busybox  
ENV HOST_COMMAND_ON_STOP docker stop busybox  
  
ENV LISTEN_PORT 80  
ENV CLIENT_REFRESH_SECS 30  
ENV CONTAINER_LIFETIME 1h  
ENV FIFO_PATH /pipe  
  
ADD files/runme.sh /runme.sh  
  
RUN chmod +x /*.sh  
  
ENTRYPOINT /runme.sh  

