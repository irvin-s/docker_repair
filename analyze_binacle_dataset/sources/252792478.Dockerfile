FROM httpd:2.4  
MAINTAINER Dang Mai <contact@dangmai.net>  
  
RUN apt-get update && apt-get install -y nodejs npm  
RUN rm -rf /usr/local/apache2/htdocs/*  
  
WORKDIR /usr/local/apache2/htdocs  
ADD [".", "/usr/local/apache2/htdocs/"]  
  
RUN npm install && npm run build && npm run clean  
  
EXPOSE 80

