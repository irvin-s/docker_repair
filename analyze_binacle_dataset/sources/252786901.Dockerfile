FROM node:8.9-alpine as angular-built  
WORKDIR /usr/src/app  
RUN npm i -g @angular/cli  
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]  
RUN npm install --silent  
COPY . .  
RUN ng build --prod  
  
FROM nginx  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
COPY \--from=angular-built /usr/src/app/dist/ /usr/share/nginx/html  
  
EXPOSE 80  
CMD [ "nginx", "-g", "daemon off;" ]

