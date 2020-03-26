FROM ubuntu:14.04  
RUN apt-get update && apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -  
RUN sudo apt-get install -y nodejs  
COPY package.json /app/package.json  
RUN cd /app; npm install  
COPY . /app  
EXPOSE 8080  
WORKDIR /app  
CMD ["npm", "run", "serve"]  

