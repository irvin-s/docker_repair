FROM nginx  
  
RUN mkdir -p /usr/share/nginx/html/dist  
  
COPY ./example /usr/share/nginx/html  
COPY ./dist /usr/share/nginx/html/dist

