FROM node:carbon  
  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
ADD . /usr/src/app  
RUN npm install  
  
ENV NODE_ENV=production  
  
RUN npm run build  
  
# Remove unused directories  
RUN rm -rf ./src  
RUN rm -rf ./build  
  
# ALPINE  
FROM nginx:alpine  
WORKDIR /usr/share/nginx/html  
COPY \--from=0 /usr/src/app/dist .  
  
# Port to expose  
EXPOSE 80  
CMD ["nginx", "-g", "daemon off;"]

