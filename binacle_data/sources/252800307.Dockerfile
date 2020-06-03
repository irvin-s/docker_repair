FROM nginx  
MAINTAINER Dogstudio <developers@dogstudio.be>  
  
COPY nginx/*.conf /etc/nginx/  
COPY nginx/conf.d/*.conf /etc/nginx/conf.d/  
  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
  
# App dir  
RUN mkdir -p /var/www  
WORKDIR /var/www  
VOLUME /var/www  
  
EXPOSE 80 443  

