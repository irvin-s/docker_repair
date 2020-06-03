FROM abaez/luarocks:openresty  
  
RUN luarocks install lapis  
  
# Make server directory  
RUN mkdir /app  
WORKDIR /app  
  
ENV LAPIS_OPENRESTY "/opt/openresty/nginx/sbin/nginx"  
VOLUME /app  
  
EXPOSE 8080 80  
ENTRYPOINT ["/usr/local/bin/lapis"]  
  
CMD ["server", "development"]  

