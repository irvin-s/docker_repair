FROM node:alpine  
  
MAINTAINER Carlos Yagüe, carlos.yague@upf.edu  
  
RUN mkdir /home/task  
RUN mkdir /home/input  
RUN mkdir /home/output  
  
WORKDIR /home/  
  
ADD . ./task  
  
WORKDIR /home/task  
  
RUN rm -rf node_modules  
RUN npm install  
RUN npm run build  
  
WORKDIR /home/  
  
CMD ["sh", "-c","node /home/task/dist/index.js /home/input /home/output"]

