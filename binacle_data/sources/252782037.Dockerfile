FROM openresty/openresty:centos-rpm  
MAINTAINER Raymond Ho <chunkiat82@gmail.com>  
  
#RUN apt-get -y update && apt-get install -y git  
# Install modules  
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt  
  
CMD ["/usr/bin/openresty", "-g", "daemon off;"]

