FROM node:5.6  
RUN mkdir /app  
ADD package.json /app/package.json  
  
WORKDIR /app  
ADD . /app  
#RUN ls -lah /app && du -sch /app  
RUN npm install  
  
CMD ["npm", "start"]  

