FROM node:alpine  
RUN apk update && \  
apk add git && \  
git clone https://github.com/angular/quickstart.git /var/www/angular && \  
cd /var/www/angular && \  
rm -rf .git && \  
xargs rm -rf < non-essential-files.osx.txt && \  
rm src/app/*.spec*.ts && \  
rm non-essential-files.osx.txt && \  
npm install  
  
WORKDIR /var/www/angular  
  
EXPOSE 8080 3000 3001  
CMD npm start  

