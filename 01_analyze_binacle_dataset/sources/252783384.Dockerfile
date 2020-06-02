FROM nginx:latest  
MAINTAINER developer@sanctuarydigital.com  
  
RUN apt-get update  
  
RUN rm /etc/nginx/conf.d/default.conf  
  
COPY config/default.conf /etc/nginx/conf.d/default.conf  
  
EXPOSE 80  
CMD ["nginx", "-g", "daemon off;"]  
  

