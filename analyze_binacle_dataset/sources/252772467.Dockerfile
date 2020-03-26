FROM node:8-alpine  
  
WORKDIR /app  
COPY . /app  
  
RUN npm install && \  
npm cache clean --force  
  
USER node  
  
CMD ["npm","start"]

