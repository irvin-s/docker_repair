FROM nginx  
  
# Remove the defaults from nginx  
RUN rm /etc/nginx/conf.d/default.conf  
#RUN rm /etc/nginx/conf.d/examplessl.conf  
  
# Copy our config over  
COPY server.conf /etc/nginx/conf.d/  

