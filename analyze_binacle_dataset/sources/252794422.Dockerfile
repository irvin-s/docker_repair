FROM nginx:mainline-alpine  
maintainer mfenner@datacite.org  
  
COPY default.conf /etc/nginx/conf.d/  

