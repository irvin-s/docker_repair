FROM nginx:stable  
MAINTAINER Egor Zyuskin <ezyuskin@codenetix.com>  
  
ADD ./etc/ /etc/  
ADD ./usr/ /usr/  
  
EXPOSE 80 443  
VOLUME ["/etc/nginx/conf.d/", "/etc/nginx/ssl"]  
  
ENTRYPOINT ["/usr/sbin/container-entrypoint.sh"]  
CMD ["nginx", "-g", "daemon off;"]  

