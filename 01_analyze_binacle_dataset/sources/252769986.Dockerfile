FROM node:5  
RUN apt-get update && apt-get install -y  
  
WORKDIR /home/app  
  
ADD . /home/app  
  
RUN npm install  
  
CMD ["npm", "run", "start"]

