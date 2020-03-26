FROM centralping/node:latest  
  
MAINTAINER Jason Cust <jason@centralping.com>  
  
ENV APP_DIR /var/app  
  
USER root  
RUN mkdir -p ${APP_DIR} && \  
chown -R node.node ${APP_DIR}  
  
USER node  
WORKDIR ${APP_DIR}  
  
ONBUILD COPY package.json ${APP_DIR}  
ONBUILD RUN npm i && \  
npm cache clear  
ONBUILD COPY . ${APP_DIR}  
  
CMD ["npm", "start"]  

