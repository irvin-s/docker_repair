FROM node:8.11.2-alpine  
LABEL maintainer "Eric Hartline <eric.hartline@northwestern.edu>"  
LABEL maintainer "Siddhartha Basu <siddhartha-basu@northwestern.edu>"  
  
RUN mkdir /app  
WORKDIR /app  
  
COPY index.js package.json package-lock.json ./  
ADD cmds cmds  
ADD data data  
  
# Install necessary packages and link the runner  
RUN npm install && npm link  
  
ENTRYPOINT ["content-manager"]  

