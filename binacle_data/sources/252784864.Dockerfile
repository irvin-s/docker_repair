FROM mhart/alpine-node:0.12  
ENV NODE_ENV production  
  
WORKDIR /app  
  
COPY package.json /app/  
  
RUN apk add --update make gcc g++ python \  
&& npm install \  
&& npm cache clean \  
&& apk del make gcc g++ python \  
&& rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp  
  
COPY . /app  
  
EXPOSE 28778  
CMD ["node", "server.js"]  

