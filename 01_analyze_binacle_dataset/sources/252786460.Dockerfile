###########################  
#Proxy another docker container to nginx x exposed port 8080  
##########################  
FROM nginx  
##  
#Added this reverse proxy  
RUN rm /etc/nginx/nginx.conf  
COPY nginx.conf /etc/nginx  
#  
EXPOSE 8080  
CMD service nginx start  
#END of adding stuff for static images  
###  

