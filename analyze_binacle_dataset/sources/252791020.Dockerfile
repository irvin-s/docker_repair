from mhart/alpine-node:8  
COPY package.json .  
RUN npm install  
ENV PORT=8080  
ENV DEBUG=electon-crashdump-s3  
  
# Bundle app source  
COPY . .  
  
EXPOSE 8080  
CMD [ "npm", "start" ]

