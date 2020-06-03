FROM amazeeio/centos:7  
MAINTAINER amazee.io  
  
RUN yum install -y epel-release && \  
yum install -y \  
nginx && \  
yum clean all  
  
COPY container-entrypoint /usr/sbin/container-entrypoint  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY fastcgi.conf /etc/nginx/fastcgi.conf  
COPY fastcgi.conf /etc/nginx/fastcgi_params  
  
RUN mkdir -p /app /etc/nginx/sites && \  
fix-permissions /app && \  
fix-permissions /etc/nginx/ && \  
fix-permissions /var/log/nginx/ && \  
fix-permissions /var/lib/nginx/ && \  
fix-permissions /run/  
  
ENTRYPOINT ["container-entrypoint"]  
CMD [ "nginx" ]  

