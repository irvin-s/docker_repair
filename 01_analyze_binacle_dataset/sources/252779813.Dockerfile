FROM node:8  
ARG NODE_ENV  
ENV NODE_ENV $NODE_ENV  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json yarn.lock /usr/src/app/  
RUN yarn install && yarn cache clean  
  
COPY . /usr/src/app  
  
RUN yarn lint  
RUN yarn test  
  
CMD ["yarn", "start"]  

