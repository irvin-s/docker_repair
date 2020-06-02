FROM openresty/openresty:1.11.2.3-alpine  
MAINTAINER Hans Kristian Flaatten <hans.flaatten@evry.com>  
  
RUN \  
apk update && \  
apk upgrade && \  
apk add \--no-cache ca-certificates curl perl && \  
opm get zmartzone/lua-resty-openidc=1.5.2 && \  
opm get bungle/lua-resty-template=1.9 && \  
apk del curl perl && \  
mkdir -p /usr/local/openresty/nginx/conf/hostsites/ && \  
true  
  
COPY bootstrap.sh /usr/local/openresty/bootstrap.sh  
COPY nginx /usr/local/openresty/nginx/  
  
ENTRYPOINT ["/usr/local/openresty/bootstrap.sh"]  

