FROM node  
  
# Get boilerplate  
COPY /app /app  
  
VOLUME /app  
  
WORKDIR /app  
  
EXPOSE 9090  
EXPOSE 9091

