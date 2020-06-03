FROM ubuntu:14.04  
RUN apt-get update #don't cache me, bro  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -  
RUN apt-get update --fix-missing  
RUN apt-get install -y nodejs python python-pip  
  
RUN pip install awscli  
  
WORKDIR /opt/app  
  
COPY package.json /opt/app/  
RUN npm install  
  
COPY . /opt/app/  
  
CMD ["node", "/opt/app/index.js"]  

