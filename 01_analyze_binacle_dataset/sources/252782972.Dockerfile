FROM node  
ADD ./app.js /coil/  
ADD ./db.js /coil/  
ADD ./configMgmt.js /coil/  
ADD ./package.json /coil/  
ADD ./public /coil/public  
ADD ./routes /coil/routes  
ADD ./controllers /coil/controllers  
ADD ./views /coil/views  
RUN cd /coil && npm install  
ADD ./config.js /coil/  
WORKDIR /coil  
ENTRYPOINT ["npm", "start"]  

