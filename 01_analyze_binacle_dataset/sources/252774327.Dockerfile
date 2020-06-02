# take default image of node boron i.e node 6.x  
FROM node:8.9.1  
RUN npm i -g yarn  
  
# create app directory in container  
RUN mkdir -p /app  
  
# set /app directory as default working directory  
WORKDIR /app  
  
# only copy package.json initially so that `RUN yarn` layer is recreated only  
# if there are changes in package.json  
ADD . /app/  
RUN yarn  
  
# compile to ES5  
RUN yarn build  
  
# expose port 4001  
EXPOSE 4001  
# cmd to start service  
CMD [ "node", "dist/index.js" ]  

