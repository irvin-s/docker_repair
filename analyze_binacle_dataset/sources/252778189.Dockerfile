FROM node:10.2.1  
WORKDIR /usr/src/app  
  
COPY package*.json ./  
RUN npm i -g npm@6.1.0  
RUN npm i -g babel-cli@6.26.0  
RUN npm i --only=production  
RUN npm i babel-plugin-transform-runtime@6.23.0  
COPY . .  
RUN npm run build  
RUN rm -rf src  
RUN npm uninstall -g babel-cli  
RUN npm uninstall babel-plugin-transform-runtime  
ENV NODE_ENV production  
  
EXPOSE 80  

