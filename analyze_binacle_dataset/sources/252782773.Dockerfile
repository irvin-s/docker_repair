FROM node:8.9.3  
EXPOSE 3000  
RUN mkdir -p src  
WORKDIR /src  
ADD . /src  
RUN yarn install  
RUN yarn build  
CMD ["yarn", "run", "start:prod"]

