FROM node:alpine  
  
# create directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# install dependencies  
COPY package.json package.json  
COPY yarn.lock yarn.lock  
RUN yarn install  
  
# build source  
COPY config config  
COPY source source  
RUN yarn run build  
  
# install production dependencies  
RUN rm -r source/ node_modules/  
RUN yarn install --production  
  
# expose port  
EXPOSE 8080  
# Environment variables (updated by build hook)  
# {{ENV}}  
# run  
CMD ["yarn", "run", "start"]  

