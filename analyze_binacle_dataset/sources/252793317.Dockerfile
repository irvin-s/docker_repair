# specify the node base image with your desired version node:<version>  
FROM node:8  
RUN npm install webpack -g  
  
# replace this with your application's default port  
EXPOSE 8080  
ENV NODE_ENV=development  
ENV APP_DIR=/home/node/app  
  
# Install the dependencies first so they can be cached  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p ${APP_DIR} && cp -a /tmp/node_modules ${APP_DIR}/  
  
COPY ./* ${APP_DIR}/  
  
RUN set -x  
RUN chown -R node:node ${APP_DIR}  
RUN chmod -R 777 ${APP_DIR}  
  
WORKDIR ${APP_DIR}  
  
USER node  
  
RUN webpack  
  
RUN ${APP_DIR}/setup.sh  
  
ENTRYPOINT ["./entrypoint.sh"]

