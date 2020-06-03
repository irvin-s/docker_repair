  
FROM alpine:edge  
  
RUN \  
apk add --update nginx && \  
rm -rf /var/cache/apk/* && \  
chown -R nginx:www-data /var/lib/nginx && \  
mkdir -p /app && chown -R nginx:www-data /app && \  
ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log  
  
VOLUME ["/etc/nginx/conf.d", "/app"]  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  
  

