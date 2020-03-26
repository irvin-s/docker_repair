FROM nginx:1.13.12-alpine  
  
RUN apk add --no-cache certbot openssl && \  
mkdir /etc/letsencrypt && \  
mkdir /etc/nginx/ssl  
  
WORKDIR /usr/share/nginx/html  
  
ADD ./root /  
COPY ./ ./  
RUN rm -rf root  
  
CMD ["/run.sh"]  

