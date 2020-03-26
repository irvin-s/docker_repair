FROM node  
  
MAINTAINER Genar <genar@alvarium.io>  
  
COPY . /app  
  
WORKDIR /app  
  
RUN yarn install --only=production  
  
ENV NODE_ENV production  
  
ENTRYPOINT ["yarn","start"]  

