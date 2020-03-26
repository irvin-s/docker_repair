FROM node:8.0-alpine  
  
ENV NPM_CONFIG_LOGLEVEL warn  
  
ENV NODE_ENV development  
  
ENV PORT 3000  
RUN mkdir -p /usr/src/app  
  
COPY . usr/src/app  
  
WORKDIR /usr/src/app  
  
COPY yarn.lock /usr/src/app  
  
RUN yarn install  
  
EXPOSE 3000  
CMD [ "yarn", "start" ]  
  

