FROM node:9.1.0  
COPY /docker-entrypoint.sh /  
RUN npm install -g iota-pm && chmod +x /docker-entrypoint.sh  
EXPOSE 80  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  

