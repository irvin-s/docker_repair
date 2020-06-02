from node  
  
ADD . /home/pirrot/app  
WORKDIR /home/pirrot/app  
RUN npm install  
ENV NODE_ENV production  
CMD [ "node", "." ]  

