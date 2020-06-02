FROM node:8  
RUN apt-get update && apt-get -y upgrade  
  
# Set environment variables  
ENV appDir /app  
  
# Set the work directory  
RUN mkdir -p /app  
WORKDIR ${appDir}  
# Add our package.json and install *before* adding our app files  
ADD package.json ./  
  
RUN npm i --production  
  
# Add app files  
ADD . /app  
  
#Expose the port  
EXPOSE 3000  
  
ENTRYPOINT npm run production

