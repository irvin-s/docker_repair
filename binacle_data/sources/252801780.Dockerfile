FROM nginx:alpine  
MAINTAINER Eduardo Sousa <ecsousa@gmail.com>  
  
ENV LISTEN_PORT=80 \  
AUTH_REALM="Restricted" \  
HTPASSWD_FILE="/etc/nginx/conf.d/auth.htpasswd" \  
HTPASSWD="" \  
FORWARD_PROTOCOL="http" \  
FORWARD_PORT=8080 \  
FORWARD_HOST="example.localhost"  
RUN apk add \--no-cache gettext \  
&& rm /etc/nginx/conf.d/default.conf  
  
ADD auth-template.conf /etc/nginx/  
ADD auth.htpasswd /etc/nginx/conf.d/  
ADD start.sh /  
  
CMD ["/start.sh"]  

