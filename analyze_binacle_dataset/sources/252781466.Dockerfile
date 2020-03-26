FROM nginx  
  
COPY ./css /usr/share/nginx/html/css  
COPY ./dist /usr/share/nginx/html/dist  
COPY ./fonts /usr/share/nginx/html/fonts  
COPY ./images /usr/share/nginx/html/images  
COPY ./js/bundle.js /usr/share/nginx/html/js/bundle.js  
COPY ./index.html /usr/share/nginx/html/index.html  

