FROM node:8-alpine  
  
ENV NODE_ENV production  
  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
RUN yarn install --force \  
&& yarn link \  
&& yarn cache clean  
  
ENTRYPOINT [ "/usr/local/bin/manuel" ]  

