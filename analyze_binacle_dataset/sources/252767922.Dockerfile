FROM node:carbon-alpine as BUILD  
  
WORKDIR /home/node/app  
  
COPY . .  
  
RUN npm install && npm run build  
  
FROM node:carbon-alpine  
  
WORKDIR /home/node/app  
  
COPY \--from=BUILD /home/node/app/dist dist  
COPY \--from=BUILD /home/node/app/cmd.sh .  
  
RUN apk add --no-cache bash  
RUN chmod +x /home/node/app/cmd.sh  
RUN npm install -g http-server  
  
EXPOSE 3000  
CMD ["/home/node/app/cmd.sh"]  

