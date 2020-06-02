FROM node:6.11.1  
MAINTAINER Rahul Shukla <shukla2009@gmail.com>  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
#RUN git clone https://github.com/shukla2009/sqs-kinesis-connector.git  
#RUN cd sqs-kinesis-connector  
RUN npm install  
  
CMD ["npm","start"]

