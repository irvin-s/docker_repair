FROM ubuntu:16.04  
ENV CODENAME=xenial  
  
RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu ${CODENAME} main" \  
> /etc/apt/sources.list.d/nginx.list  
  
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C && \  
apt-get update && \  
apt-get install -y --no-install-recommends \  
nginx-extras curl && \  
apt-get purge  
  
WORKDIR /etc/nginx  
  
EXPOSE 80  
# Forward request and error logs to docker log collector  
RUN ln -sf /dev/stdout /var/log/nginx/access.log \  
&& ln -sf /dev/stderr /var/log/nginx/error.log  
  
COPY docker-entrypoint.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["nginx", "-g", "daemon off;"]

