FROM node:7  
# Create app directory  
RUN mkdir /app  
WORKDIR /app  
  
# Install app dependencies  
COPY package.json /app/  
RUN npm install  
  
# Bundle app source  
COPY . /app  
  
EXPOSE 3000  
CMD ["npm", "start"]

