FROM node:6.3.1  
ENV APP=/code  
RUN mkdir $APP  
WORKDIR $APP  
  
COPY package.json package.json  
RUN npm i  
  
COPY . ./  
RUN npm run compile  
  
EXPOSE 80  
VOLUME ["/code/private"]  
CMD ["npm", "run", "serve"]  

