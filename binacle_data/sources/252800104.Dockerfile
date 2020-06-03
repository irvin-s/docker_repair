FROM node  
  
# Copy application files  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  
# Install Yarn and Node.js dependencies  
RUN yarn install --no-progress  
  
# Build  
RUN yarn run build --docker  
  
CMD [ "node", "./build/server.js" ]  
  
EXPOSE 3000  

