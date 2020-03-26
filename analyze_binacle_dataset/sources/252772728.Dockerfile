FROM node:8  
RUN git clone https://github.com/itteco/iframely.git  
  
WORKDIR /iframely  
  
RUN npm install  
  
ADD ./config.local.js .  
  
EXPOSE 8061  
CMD node server  

