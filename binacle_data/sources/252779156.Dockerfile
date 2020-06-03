# Use the official nginx build  
FROM nginx:latest  
  
MAINTAINER Marko Kirves <marko.kirves@bynd.com>  
  
# Disable default site  
RUN rm /etc/nginx/conf.d/default.conf  
  
# Add application configuration  
ADD django-app.conf /etc/nginx/conf.d/django-app.conf  

