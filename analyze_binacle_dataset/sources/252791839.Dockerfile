FROM nginx:latest  
MAINTAINER dan budris <dbudris@bu.edu>  
  
RUN rm /etc/nginx/conf.d/default.conf  
  
ADD ./default.conf /etc/nginx/conf.d/default.conf  

