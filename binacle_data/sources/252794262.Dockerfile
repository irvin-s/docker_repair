FROM mhart/alpine-node:5.7.1  
VOLUME ["/app"]  
WORKDIR /app  
  
RUN npm install -g spa-http-server  
  
EXPOSE 8080  
CMD ["http-server", "-d", "false", "--push-state"]  

