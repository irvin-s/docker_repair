FROM node:boron  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY package.json .  
RUN npm install  
COPY . .  
RUN ./node_modules/.bin/bower install --allow-root  
EXPOSE 3000  
CMD ["npm", "start"]

