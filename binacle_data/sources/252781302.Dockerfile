FROM node:alpine  
  
# Metadata  
LABEL maintainer="Parham Alvani <parham.alvani@gmail.com>"  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Entrypoint  
ENTRYPOINT ["node"]  
CMD ["index.js"]  

