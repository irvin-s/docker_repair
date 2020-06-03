FROM node:6  
RUN npm install pm2 -g  
  
VOLUME ["/app"]  
  
# Expose ports  
EXPOSE 80 443 3000  
WORKDIR /app  
  
# Start  
CMD ["pm2-docker", "start", "--env", "production", "/app/pm2.json"]  

