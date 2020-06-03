FROM anibali/lua:5.2  
# Install required Lua modules  
RUN apk add --update gcc lua5.2-dev musl-dev git \  
&& export C_INCLUDE_PATH=/usr/include/lua5.2/ \  
&& luarocks install etcd \  
&& luarocks install etlua \  
&& luarocks install stdlib \  
&& apk del gcc lua5.2-dev musl-dev git \  
&& rm -rf /var/cache/apk/*  
  
# Install HAProxy  
RUN apk add --update haproxy \  
&& rm -rf /var/cache/apk/*  
  
# Create PID file that we will use when reloading HAProxy  
RUN touch /var/run/haproxy.pid  
  
# Copy our scripts into the image  
COPY src /app  
COPY start_haproxy-discover.sh /  
  
# Expose HAProxy status port  
EXPOSE 1936  
ENTRYPOINT ["/usr/bin/tini", "--", "/start_haproxy-discover.sh"]  

