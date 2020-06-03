FROM node  
MAINTAINER Attila Szeremi <attila+webdev@szeremi.com>  
RUN mkdir /src  
WORKDIR /src  
RUN cd /src  
# Copy just the package.json and lock files file as a cache step.  
COPY package.json /src/package.json  
COPY package-lock.json /src/package-lock.json  
RUN npm install 2>&1  
# Now copy the rest of the files.  
COPY . .  
RUN npm run build  
EXPOSE 8080  
CMD ["npm", "run", "start"]  

