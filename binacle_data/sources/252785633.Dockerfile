FROM nginx:stable  
  
MAINTAINER Commande-Online.fr SAS  
  
COPY sites-enabled /etc/nginx/conf.d/  
  
VOLUME /usr/share/nginx/html  
  
CMD ["nginx", "-g", "daemon off;"]

