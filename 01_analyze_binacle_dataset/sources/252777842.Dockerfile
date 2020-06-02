FROM node:8.6.0 as build-deps  
  
WORKDIR /usr/src/app  
  
COPY package.json ./package.json  
RUN yarn  
# RUN yarn add serve  
# RUN npm install react-scripts-ts -g --silent  
# RUN npm rebuild node-sass --force  
# CMD serve -s build  
# EXPOSE 3000  
COPY . .  
COPY ./src/.prod.env ./src/.env  
RUN yarn build  
# RUN npm run build-css  
# RUN npm run release  
FROM nginx:1.13.9-alpine  
RUN rm -rf /etc/nginx/conf.d  
COPY conf /etc/nginx  
COPY \--from=build-deps /usr/src/app/build /usr/share/nginx/html  
EXPOSE 80 8080  
CMD ["nginx", "-g", "daemon off;"]

