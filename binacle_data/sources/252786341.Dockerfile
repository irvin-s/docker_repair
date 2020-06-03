FROM nginx:latest  
RUN groupmod -g 82 www-data \  
&& usermod -u 82 www-data  

