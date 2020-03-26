FROM node:8-alpine as build  
  
WORKDIR /usr/src/app  
COPY package.json /usr/src/app  
RUN yarn install  
  
COPY ./public /usr/src/app/public  
COPY ./src /usr/src/app/src  
RUN yarn build  
  
EXPOSE 3000  
CMD ["yarn", "start"]  
  
FROM giantswarm/caddy:0.10.4-slim  
COPY \--from=build /usr/src/app/build /var/www  

