FROM acarrusca/nginx-load-balancer-api  
  
FROM nginx:alpine  
  
# for htpasswd command  
RUN apk add --no-cache --update \  
apache2-utils  
RUN rm -f /etc/nginx/conf.d/*  
  
ENV SERVER_NAME load-balancer.com  
  
COPY \--from=0 /nginx-load-balancer-api ./nginx-load-balancer-api  
COPY files/run.sh /  
COPY files/nginx.conf.tmpl /  
  
# use SIGQUIT for graceful shutdown  
# c.f. http://nginx.org/en/docs/control.html  
STOPSIGNAL SIGQUIT  
  
ENTRYPOINT ["/run.sh"]

