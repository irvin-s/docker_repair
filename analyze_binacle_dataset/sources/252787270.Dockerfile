FROM node:argon  
  
MAINTAINER Bjorgvin Reynisson  
  
ENV PORT=5000  
COPY . /var/www  
WORKDIR /var/www  
  
RUN npm install \  
&& npm install bower -g \  
&& bower install --allow-root  
  
EXPOSE $PORT 5432  
CMD ["npm", "start"]

