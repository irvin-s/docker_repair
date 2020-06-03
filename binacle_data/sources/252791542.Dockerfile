#FROM node:8.11.2 as build-deps  
  
#WORKDIR /usr/src/app  
#COPY package.json yarn.lock ./  
#RUN yarn  
#COPY . ./  
#RUN yarn build  
  
#FROM nginx:1.12-alpine  
#COPY \--from=build-deps /usr/src/app/build /usr/share/nginx/html  
#COPY default.conf /etc/nginx/conf.d/  
#EXPOSE 5000  
#CMD ["nginx", "-g", "daemon off;"]  
  
FROM node:8.11.2 as build-deps  
WORKDIR /usr/src/app  
COPY package.json yarn.lock ./  
RUN yarn  
COPY . ./  
  
EXPOSE 5000  

