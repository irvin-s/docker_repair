FROM nginx:stable  
  
COPY conf.d/nginx.conf /etc/nginx/conf.d/nginx.conf  
  
RUN rm /etc/nginx/conf.d/default.conf  
  
EXPOSE 80  
CMD ["nginx", "-g", "daemon off;"]  

