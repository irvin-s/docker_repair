FROM algas/docker-node-modules:base-test-1  
USER ubuntu  
ENV NODE_DIR /home/ubuntu/node  
ENV LOG_DIR /home/ubuntu/log  
RUN mkdir -p $NODE_DIR $LOG_DIR  
COPY package.json $NODE_DIR/  
  
WORKDIR $NODE_DIR  
RUN \  
npm install && \  
npm ls --depth=0 > $LOG_DIR/installed.log  
  
ENTRYPOINT ["cat", "/home/ubuntu/log/installed.log"]  

