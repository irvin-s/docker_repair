# Use node 4.4.5 LTS  
FROM node:latest  
  
# Copy source code  
COPY . /app  
  
# Change working directory  
WORKDIR /app  
  
# Install dependencies  
RUN npm install  
  
# Expose API port to the outside  
EXPOSE 80  
EXPOSE 4321  
# Launch application  
CMD npm start

