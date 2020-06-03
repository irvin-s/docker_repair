FROM node:carbon  
  
# Install app dependencies  
RUN git clone https://github.com/TampereTC/NEO-Hackathon-vol4-CM15 && \  
cd NEO-Hackathon-vol4-CM15  
  
# Create working directory  
WORKDIR NEO-Hackathon-vol4-CM15  
  
# Install project dependencies  
RUN npm install  
  
# If you are building your code for production  
#RUN npm install --only=production  
# Create container volume  
VOLUME ["NEO-Hackathon-vol4-CM15"]  
  
# Exposing to external enviornment  
EXPOSE 3001  
# Start server  
CMD [ "node", "index.js" ]  

