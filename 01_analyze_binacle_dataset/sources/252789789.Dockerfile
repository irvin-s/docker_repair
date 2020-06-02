FROM node:8.1.0  
WORKDIR /app  
  
COPY package.json /app  
COPY yarn.lock /app  
RUN yarn install  
  
COPY . /app  
RUN node --max_old_space_size=4096 node_modules/typescript/bin/tsc  
  
EXPOSE 8093  
CMD [ "npm", "run", "prod" ]

