FROM node:8.11.1  
WORKDIR /work-dir  
COPY package.json /work-dir  
RUN npm install  
COPY . /work-dir  
CMD npm start  
EXPOSE 1337

