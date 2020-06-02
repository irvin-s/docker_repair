FROM openresty/openresty:alpine  
  
# Bring in gettext so we can get `envsubst`, then throw  
# the rest away. To do this, we need to install `gettext`  
# then move `envsubst` out of the way so `gettext` can  
# be deleted completely, then move `envsubst` back.  
RUN apk add --no-cache --virtual .gettext gettext \  
&& apk add --no-cache libintl \  
&& mv /usr/bin/envsubst /tmp/ \  
&& apk del .gettext \  
&& mv /tmp/envsubst /usr/local/bin/  
  
ADD proxy.conf /usr/local/openresty/nginx/conf/proxy.conf  
ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf.tpl  
ADD entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  

