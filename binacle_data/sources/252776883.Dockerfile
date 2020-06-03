FROM nginx:latest  
  
COPY _site /usr/share/nginx/html  
  
EXPOSE 80  
CMD echo 'The webserver is now running'; nginx -g "daemon off;"  
  

