FROM node:4-slim  
  
WORKDIR /src  
  
COPY app.js ./  
COPY package.json ./  
  
RUN npm i  
  
EXPOSE 4785  
CMD ["node", "--use-strict", "app.js"]

