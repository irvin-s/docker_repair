FROM ubuntu:16.04  
#AVOID_CACHE  
RUN touch /tmp/1486221943  
#AVOID_CACHE_END  
RUN apt-get update \  
&& apt-get install --no-install-recommends --no-install-suggests -y \  
ca-certificates \  
nginx \  
git\  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /opt/  
  
# forward request and error logs to docker log collector  
RUN ln -sf /dev/stdout /var/log/nginx/access.log \  
&& ln -sf /dev/stderr /var/log/nginx/error.log  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  

