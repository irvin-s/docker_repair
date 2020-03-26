FROM mhart/alpine-node:4  
ENV VERSION 1.0  
ENV DOCKER_USER="dockerfront"  
ENV USR_LOCAL=/usr/local  
ENV ENV_SHARED=$USR_LOCAL/share  
  
COPY package.json $USR_LOCAL/package.json  
COPY npm-shrinkwrap.json $USR_LOCAL/npm-shrinkwrap.json  
  
RUN npm install -g gulp@3.9.0 && \  
addgroup $DOCKER_USER && \  
adduser -s /bin/sh -D -G $DOCKER_USER $DOCKER_USER && \  
cd $USR_LOCAL && \  
npm install && \  
mkdir $ENV_SHARED/config && \  
mkdir $ENV_SHARED/tasks && \  
mkdir $ENV_SHARED/input && \  
mkdir $ENV_SHARED/output  
  
VOLUME $ENV_SHARED/config  
VOLUME $ENV_SHARED/tasks  
VOLUME $ENV_SHARED/input  
VOLUME $ENV_SHARED/output  
  
ADD entrypoint.sh /root/entrypoint.sh  
RUN chmod +x /root/entrypoint.sh  
ENTRYPOINT ["/root/entrypoint.sh"]  

