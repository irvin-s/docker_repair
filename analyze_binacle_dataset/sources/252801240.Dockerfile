FROM node:8.4.0-alpine  
  
# Increase npm install performance  
RUN npm set progress=false  
  
COPY ./docker-entrypoint.sh /  
  
WORKDIR /app  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["start"]  

