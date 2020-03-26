FROM nginx:stable-alpine  
  
RUN apk add --update bash \  
&& rm /etc/nginx/nginx.conf \  
&& rm /etc/nginx/nginx.conf.default \  
&& mkdir /usr/local/share/www \  
&& mkdir /www  
  
WORKDIR /usr/local/share/  
  
COPY . .  
  
RUN chmod +x ./docker-cmd  
  
ENTRYPOINT ["/bin/bash", "-c"]  
EXPOSE 80 443  
# CMD ["nginx", "-g", "'daemon off;'"]  
CMD ["./docker-cmd"]  
  

