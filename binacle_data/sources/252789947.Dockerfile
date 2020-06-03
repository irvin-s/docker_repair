# Use node 4.4.5 LTS  
FROM node:8.11.0  
# Copy source code  
COPY . /app  
  
# Change working directory  
WORKDIR /app  
  
# Install dependencies  
RUN npm install  
  
# Launch application  
CMD ["npm","start"]

