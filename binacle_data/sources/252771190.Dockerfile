FROM node:8  
LABEL maintainer="lbonnargent@matlo.com" \  
Description="Capture message from slack to display them in Matlo dashboard"  
  
EXPOSE 3500  
ENV SLACK_TOKEN ""  
ENV MATLO_TOKEN ""  
ENV MATLO_USER ""  
ENV MATLO_DASHBOARD ""  
WORKDIR /home/node/app  
  
ADD package.json /home/node/app/package.json  
ADD package-lock.json /home/node/app/package-lock.json  
  
RUN npm i  
  
ADD metadata.json /home/node/app/metadata.json  
ADD main.js /home/node/app/main.js  
  
ENTRYPOINT ["npm", "start"]  

