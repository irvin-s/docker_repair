FROM nginx  
RUN rm /etc/nginx/conf.d/*  
COPY nginx.conf /etc/nginx/conf.d/redirect.conf  
  

