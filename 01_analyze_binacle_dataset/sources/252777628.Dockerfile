  
FROM gliderlabs/alpine  
  
COPY dht-bootstrap /bin/dht-bootstrap  
RUN apk --update add libgcc libstdc++ musl; chmod +x /bin/dht-bootstrap  
  
EXPOSE 6881  
CMD ["dht-bootstrap", "0.0.0.0"]  

