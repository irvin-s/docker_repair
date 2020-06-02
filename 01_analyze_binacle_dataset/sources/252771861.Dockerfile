FROM node:alpine  
  
MAINTAINER nubzoar  
  
ADD start-remindme.sh /start-remindme.sh  
  
RUN apk update && \  
apk add git && \  
chmod +x /start-remindme.sh && \  
npm install -g nodemon && \  
git clone https://github.com/nubzoar/remindme && \  
cd /remindme && \  
sed -i 's/localhost/mongo/' /remindme/routes/emails.js && \  
npm install  
  
# Expose Port  
EXPOSE 3000  
# Command executed on container start.  
ENTRYPOINT ["/start-remindme.sh"]  

