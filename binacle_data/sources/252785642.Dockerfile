FROM nginx:latest  
  
MAINTAINER thomasdolar@gmail.com  
  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
  
RUN mkdir -p /var/commercefacile/cert  
  
COPY ./.cert/certificate.pem /var/commercefacile/cert/certificate.pem  
COPY ./.cert/private.key /var/commercefacile/cert/private.key  
  
# ENTRYPOINT ["nginx"]  
# CMD ["-g", "daemon off;"]

