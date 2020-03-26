FROM node:6.11.1  
WORKDIR /tmp  
COPY package.json npm-shrinkwrap.json /tmp/  
  
COPY . /usr/src/app/  
RUN npm install \  
&& cp -a /tmp/node_modules /usr/src/app \  
&& cd /usr/src/app/ \  
&& npm cache clean --force \  
&& npm run build \  
&& npm prune --production  
  
WORKDIR /usr/src/app  
  
ARG PORT=80  
ENV PORT $PORT  
EXPOSE $PORT  
  
ARG NODE_ENV=production  
ENV NODE_ENV $NODE_ENV  
  
CMD [ "node", "index.js" ]  

