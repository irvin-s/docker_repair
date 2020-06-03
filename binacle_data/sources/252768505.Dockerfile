FROM node  
EXPOSE 80  
ADD . /  
RUN npm install  
CMD npm start  

