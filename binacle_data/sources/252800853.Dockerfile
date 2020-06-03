FROM node:8-alpine  
  
RUN mkdir /home/node/app  
WORKDIR /home/node/app  
  
RUN mkdir /home/node/.ssh  
ADD ./gitlabKey /home/node/.ssh/id_rsa  
RUN chmod 600 /home/node/.ssh/id_rsa  
RUN echo 'Host *gitlab.com' > /home/node/.ssh/config  
RUN echo 'UserKnownHostsFile=/dev/null' >> /home/node/.ssh/config  
RUN echo 'StrictHostKeyChecking=no' >> /home/node/.ssh/config  
  
COPY ./package.json package.json  
COPY ./client client  
COPY ./server server  
COPY ./config.js config.js  
RUN chown node:node -R ./  
  
USER node  
RUN npm i --production  
CMD npm start  

