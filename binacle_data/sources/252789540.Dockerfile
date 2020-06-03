FROM nginx  
COPY ./etc/nginx /etc/nginx  
RUN ls -alh /etc/nginx  
RUN ls -alh /etc/nginx/sites-available  
  
EXPOSE 80  

