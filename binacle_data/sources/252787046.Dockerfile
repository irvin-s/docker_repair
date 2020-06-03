FROM node:8  
MAINTAINER Alex Forbes-Reed <dockerfile@alx.red>  
  
ENV NODE_ENV="production" \  
PORT="80"  
RUN mkdir -p /usr/local/app  
WORKDIR /usr/local/app  
  
COPY package.json /usr/local/app  
RUN npm install --production=false \--silent  
  
COPY . /usr/local/app  
RUN npm run build  
  
EXPOSE 80  
CMD ["npm", "start"]  

