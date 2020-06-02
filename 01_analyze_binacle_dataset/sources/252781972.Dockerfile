ARG RESTY_CONFIG_OPTIONS="\  
\--with-file-aio \  
\--with-http_realip_module \  
\--with-http_stub_status_module \  
\--with-http_v2_module \  
\--with-ipv6 \  
\--with-md5-asm \  
\--with-pcre-jit \  
\--with-sha1-asm \  
\--with-stream \  
\--with-threads \  
"  
FROM openresty/openresty:1.13.6.1-alpine  
  
EXPOSE 8080  
EXPOSE 8433  
EXPOSE 8111  
RUN apk add --no-cache gettext  
CMD ["/bin/sh", "/root/start.sh"]  
  
HEALTHCHECK \--interval=1m --timeout=2s \  
CMD curl -f http://localhost:8111/ || exit 1  
  
COPY start.sh /root/start.sh  
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf  
COPY afr.lua /usr/local/openresty/nginx/afr.lua  
COPY lookup.lua /usr/local/openresty/nginx/lookup.lua

