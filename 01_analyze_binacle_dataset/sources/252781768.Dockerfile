FROM tutum/nginx  
RUN rm /etc/nginx/sites-enabled/default  
COPY sites-enabled/ /etc/nginx/sites-enabled  
#RUN rm /etc/nginx/nginx.conf  
#COPY nginx.conf /etc/nginx/nginx.conf  

