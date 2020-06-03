# cloudfleet musterroll  
#  
# VERSION 0.1  
FROM library/node:7.5  
RUN apt-get update && apt-get install -y git-core python make g++  
  
WORKDIR /opt/cloudfleet/app  
  
COPY package.json /opt/cloudfleet/app/  
RUN npm install  
COPY . /opt/cloudfleet/app  
  
CMD ["npm", "start"]  
  
EXPOSE 80  
EXPOSE 389  

