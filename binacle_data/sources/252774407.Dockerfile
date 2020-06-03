FROM node:8-alpine  
WORKDIR /build  
COPY package.json /build  
RUN npm install --production  
COPY . /build  
#VOLUME /build  
EXPOSE 8080  
USER node  
VOLUME [ "/build/logs" ]  
CMD ["node","src/api/index.js"]

