FROM alpine  
  
RUN mkdir -p /usr/bin  
COPY ./bin/devdns /usr/bin/devdns  
  
# Port, defaults to 5300  
EXPOSE 5300  
CMD ["/usr/bin/devdns", "-ip", "127.0.0.1", "-addr", "0.0.0.0:5300"]  

