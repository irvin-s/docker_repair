FROM node:6.6.0  
ENV APP=/code  
RUN mkdir $APP  
WORKDIR $APP  
  
COPY package.json package.json  
RUN npm i  
  
COPY . ./  
  
EXPOSE 3000  
VOLUME ["/code"]  
CMD ["npm", "run", "start"]  

