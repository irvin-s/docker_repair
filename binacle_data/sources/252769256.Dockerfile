FROM anibali/alpine-tini:3.2  
# Install Lua and LuaRocks  
RUN apk add --update \  
\--repository http://dl-1.alpinelinux.org/alpine/edge/testing/ \  
lua5.2 luarocks5.2 ca-certificates curl unzip \  
&& rm -rf /var/cache/apk/*  
  
# Create links  
RUN ln -s /usr/bin/lua5.2 /usr/bin/lua \  
&& ln -s /usr/bin/luarocks-5.2 /usr/bin/luarocks  
  
ENTRYPOINT ["/usr/bin/tini", "--", "lua"]  

