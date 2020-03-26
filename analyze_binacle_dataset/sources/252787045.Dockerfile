FROM node:8  
MAINTAINER Alex Forbes-Reed <dockerfile@alx.red>  
  
ENV NODE_ENV="production" \  
PORT="80"  
RUN mkdir -p /usr/local/app  
WORKDIR /usr/local/app  
  
COPY package.json /usr/local/app  
RUN npm install --production=false \--silent  
RUN npm install --global bower  
  
COPY . /usr/local/app  
RUN bower install --allow-root  
RUN npm run transpile  
RUN npm run build  
  
EXPOSE 80  
CMD ["npm", "start"]  

