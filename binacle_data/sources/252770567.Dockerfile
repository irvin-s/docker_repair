FROM mhart/alpine-node:6  
MAINTAINER aensidhe  
  
ENV NODE_CONFIG_DIR ./config  
ENV NODE_PATH $NODE_PATH:./node_modules:  
  
ENV APP_HOME /opt/app  
  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p $APP_HOME && cp -a /tmp/node_modules $APP_HOME  
  
WORKDIR $APP_HOME  
ADD . $APP_HOME  
  
RUN node_modules/typescript/bin/tsc -p .  
  
EXPOSE 80  
CMD ["node", "artifacts/index.js"]

