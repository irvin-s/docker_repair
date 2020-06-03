FROM node:8.6.0 as build-deps  
  
WORKDIR /usr/src/app  
COPY ./package.json ./package.json  
  
# RUN yarn global add serve  
RUN yarn  
# RUN yarn add serve  
# RUN npm install react-scripts-ts -g --silent  
# RUN npm rebuild node-sass --force  
# CMD serve -s build  
# EXPOSE 3000  
COPY . ./  
  
# COPY src/.prod.env ./src/.env  
# Uncomment from PROD  
COPY ./src/config.prod.ts ./src/config.ts  
  
RUN yarn build  
COPY ./index.prod.html /dist/index.html  
  
# RUN npm run build-css  
# RUN npm run release  
EXPOSE 5000  
# CMD ["serve", "-s", "build"]  
# FROM nginx:1.13.9-alpine  
# RUN rm -rf /etc/nginx/conf.d  
# COPY conf /etc/nginx  
# COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html  
# EXPOSE 80  
# CMD ["nginx", "-g", "daemon off;"]  
# production environment  
FROM nginx:1.13.9-alpine  
RUN rm -rf /etc/nginx/conf.d  
COPY conf /etc/nginx  
COPY \--from=build-deps /usr/src/app/dist /usr/share/nginx/html  
COPY ./index.prod.html /usr/share/nginx/html/index.html  
EXPOSE 80  
CMD ["nginx", "-g", "daemon off;"]

