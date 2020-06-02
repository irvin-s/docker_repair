FROM nginx:mainline  
MAINTAINER 25th-floor GmbH <devops@25th-floor.com>  
  
ENV WORKER_PROCESSES 4  
ENV UPSTREAM_PROTO http  
ENV UPSTREAM_CONNECT app  
ENV UPSTREAM_PORT 80  
ENV ALLOW_IPS 0.0.0.0/0  
ENV REAL_IP_FROM 10.42.0.0/16  
ENV CLIENT_MAX_BODY_SIZE 100m  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Create directories  
RUN mkdir -p /var/nginx/client_body_temp \  
&& mkdir -p /var/nginx/proxy_temp \  
&& chown www-data.root /var/nginx/*  
  
# forward request and error logs to docker log collector  
RUN ln -sf /proc/1/fd/1 /var/log/nginx/access.log \  
&& ln -sf /proc/1/fd/2 /var/log/nginx/error.log  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY access.control /etc/nginx/access.control  
COPY entrypoint.sh /entrypoint.sh  
  
EXPOSE 80  
ENTRYPOINT ["/entrypoint.sh"]  

