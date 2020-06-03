FROM openresty/openresty:alpine-fat  
MAINTAINER Anth Courtney <anthcourtney@gmail.com>  
  
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http  

