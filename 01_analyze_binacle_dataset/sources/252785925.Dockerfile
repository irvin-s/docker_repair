# 50Mb alpine + git  
FROM bravissimolabs/alpine-git  
  
RUN apk add --update nodejs  
  
ADD . /rest-service  
  
# Install dependencies  
RUN cd /rest-service; \  
npm install --production  
  
#set working director to git repo  
WORKDIR /rest-service  
  
# Install app and dependencies into /src  
RUN npm install  
  
EXPOSE 80 22  
CMD [ "npm", "start" ]  

