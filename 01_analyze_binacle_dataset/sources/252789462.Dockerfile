FROM node:7-alpine  
  
COPY gitlabLabeller.js /usr/src/app/gitlabLabeller.js  
  
WORKDIR /usr/src/app  
  
ENTRYPOINT ["node", "gitlabLabeller.js"]  

