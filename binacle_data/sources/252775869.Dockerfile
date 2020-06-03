FROM node:8.10-alpine  
  
  
ARG WORK_PATH=/home/src  
ARG CACHE_DIR=/home/cache  
ARG CONFIG_DIR=/usr/local/share/.cache/yarn  
  
  
COPY ./build.sh /usr/bin/build  
  
RUN chmod +x /usr/bin/build \  
&& mkdir -p $WORK_PATH $CACHE_DIR $CONFIG_DIR \  
&& ln -s $CACHE_DIR "$CONFIG_DIR/v1"  
  
WORKDIR $WORK_PATH  
  
ENV SCRIPT=build  
  
  
VOLUME $CACHE_DIR  
  
ENTRYPOINT build $SCRIPT  

