FROM node:alpine  
  
RUN npm install yarn -g  
  
RUN mkdir -p /usr/src/dashboard  
WORKDIR /usr/src/dashboard  
  
COPY package.json /usr/src/dashboard/  
COPY yarn.lock /usr/src/dashboard/  
RUN yarn install  
  
COPY . /usr/src/dashboard/  
RUN yarn build  
  
VOLUME /usr/src/dashboard/config  
ENV NODE_ENV=production  
ENV PORT=80  
EXPOSE 80  
CMD [ "yarn", "server" ]  

