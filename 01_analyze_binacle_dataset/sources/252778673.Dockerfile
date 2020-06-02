FROM node  
  
ENV PORT 3000  
EXPOSE 3000  
COPY package.json package.json  
RUN npm install  
  
COPY . /  
  
ENTRYPOINT [ "npm" ]  
CMD [ "start" ]  

