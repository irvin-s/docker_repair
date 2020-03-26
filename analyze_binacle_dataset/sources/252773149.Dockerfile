FROM node:8  
RUN apt-get update && apt-get install -y \  
zbar-tools \  
ghostscript \  
pdftk \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ARG NODE_ENV  
ENV NODE_ENV $NODE_ENV  
COPY package.json /usr/src/app/  
RUN npm install && npm cache clean --force  
COPY . /usr/src/app  
  
CMD [ "npm", "start" ]

