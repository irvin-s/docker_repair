FROM node:6.9.2  
#some dummy comment  
EXPOSE 80  
COPY /src/* ./  
COPY ./package.json .  
RUN npm i  
CMD node index.js  

