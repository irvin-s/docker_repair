FROM node  
  
ENV HOME=/usr/src/app  
RUN mkdir $HOME  
WORKDIR $HOME  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 4200  
CMD [ "npm", "start" ]  

