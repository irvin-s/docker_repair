FROM alpine:3.4  
MAINTAINER arnau <asiches@gmail.com>  
  
ARG LUAROCKS_VERSION="2.3.0"  
  
RUN apk add \--update \  
\--no-cache \  
nginx-lua \  
# forward request and error logs to docker log collector  
&& ln -sf /dev/stdout /var/log/nginx/access.log \  
&& ln -sf /dev/stderr /var/log/nginx/error.log  
  
RUN apk add \--update \  
\--no-cache \  
\--virtual .build-deps \  
wget \  
make \  
git \  
unzip \  
openssl \  
openssl-dev \  
build-base \  
lua \  
lua-dev \  
&& wget http://luarocks.org/releases/luarocks-${LUAROCKS_VERSION}.tar.gz \  
&& tar zxpf luarocks-${LUAROCKS_VERSION}.tar.gz \  
&& cd luarocks-${LUAROCKS_VERSION} \  
&& ./configure \  
&& make bootstrap \  
&& luarocks install basexx \  
&& luarocks install md5 \  
&& luarocks install lua-cjson \  
&& luarocks install lua-resty-hmac \  
&& luarocks install lua-resty-jwt \  
&& luarocks install lua-resty-string \  
&& rm -rf /luarocks-${LUAROCKS_VERSION} \  
/luarocks-${LUAROCKS_VERSION}.tar.gz \  
&& apk del .build-deps  
  
COPY nginx/conf/nginx.conf /etc/nginx/nginx.conf  
COPY nginx/lua /etc/nginx/lua  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off; pid /var/run/nginx.pid;"]  

