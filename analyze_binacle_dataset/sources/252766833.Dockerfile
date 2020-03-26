from node:4.1  
RUN mkdir /usr/app  
WORKDIR /usr/app  
  
RUN npm install -g webpack gulp  
  
RUN rm -rf node_modules  
RUN rm -rf public/dist/*  
  
COPY . /usr/app  
  
RUN npm install  
RUN webpack  
RUN npm rebuild node-sass  
RUN gulp sass  
  
CMD ["node", "server.js"]  
  
EXPOSE 3000  

