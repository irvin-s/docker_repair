FROM node  
MAINTAINER Denis Carriere <carriere.denis@gmail.com>  
  
# Create app directory  
RUN mkdir -p /src  
WORKDIR /src  
  
# Install app dependencies  
RUN npm install sqlite3  
COPY package.json /src/  
RUN npm install --only=development  
RUN npm install --only=production  
  
# Bundle app source  
COPY . /src/  
RUN npm run build  
  
# Start App  
EXPOSE 5000  
CMD ["npm", "start"]  
  

