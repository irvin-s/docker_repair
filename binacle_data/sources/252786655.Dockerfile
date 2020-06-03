FROM node:latest  
LABEL maintainer "travis@toggleable.com"  
  
RUN groupadd -r nodejs && useradd -r -g nodejs nodejs  
RUN apt-get update && apt-get -y install ssmtp mutt sudo  
  
WORKDIR /home/nodejs/jsb-sync/  
  
COPY package.json /home/nodejs/jsb-sync  
  
RUN npm install  
  
COPY . /home/nodejs/jsb-sync  
  
RUN chmod +x /home/nodejs/jsb-sync/startup.sh  
RUN ln -s /usr/bin/mutt /usr/local/bin/mutt  
RUN echo set copy=no >> /etc/Muttrc  
RUN mkdir /home/nodejs/jsb-sync-data  
RUN chown nodejs:nodejs /home/nodejs/jsb-sync-data  
  
ENV NODE_ENV docker-production  
ENV NODE_PATH /home/nodejs/jsb-sync/lib/  
  
CMD ["/home/nodejs/jsb-sync/startup.sh", "/usr/local/bin/node", "index.js"]  

