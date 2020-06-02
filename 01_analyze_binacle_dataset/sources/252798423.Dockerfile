FROM node:6.9.4  
MAINTAINER ravi.k-ext@influencehealth.com  
  
ENV APP_DIR /app  
  
ADD /.ssh/predict_core_rsa /root/.ssh/id_rsa  
RUN chmod 600 /root/.ssh/id_rsa  
RUN echo " IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config  
RUN ssh-keyscan -H github.com >> /root/.ssh/known_hosts  
  
# Install NPM dependencies  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p ${APP_DIR} && cp -a /tmp/node_modules ${APP_DIR}  
  
WORKDIR ${APP_DIR}  
  
ADD . ${APP_DIR}  
  
VOLUME ${APP_DIR}/config  
  
CMD ["npm", "start"]  

