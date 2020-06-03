FROM node:6-alpine  
  
RUN apk --update --no-cache add git  
  
RUN npm i -g yarn  
  
# install aws cli  
RUN apk --no-cache add python3 groff less && \  
pip3 install awscli  
  

