FROM node  
  
WORKDIR /usr/src/app/  
  
# Install required modules  
COPY ./package.json ./npm-shrinkwrap.json /usr/src/app/  
RUN npm install && npm cache clean  
  
# Copy optimization script  
COPY optimize-images.js /usr/src/app/optimize-images.js  
  
# Execute optimize-images by default  
CMD [ "node", "/usr/src/app/optimize-images.js" ]  

