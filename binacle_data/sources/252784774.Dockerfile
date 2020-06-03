FROM node:7  
# Create sentimeter directory  
RUN mkdir -p /rosm  
WORKDIR /rosm  
  
# Variables  
ENV NODE_ENV development  
ENV DATABASE_HOST localhost  
ENV DATABASE_NAME eersel  
ENV DATABASE_USER postgres  
ENV DATABASE_PASSWORD mysecretpassword  
ENV HOST_PORT 3000  
# Install  
COPY . /rosm  
RUN npm install .  
  
CMD ["npm", "start"]  

