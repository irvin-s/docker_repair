FROM philipstanislaus/node6-with-wkhtmltopdf  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 8000  
CMD [ "npm", "start" ]  

