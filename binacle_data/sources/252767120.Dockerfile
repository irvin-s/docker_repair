# base image  
FROM node:9.6.1  
# set working directory  
RUN mkdir /usr/src/app  
WORKDIR /usr/src/app  
  
# Copy the current directory contents into the container at /app  
ADD . /usr/src/app  
  
# add `/usr/src/app/node_modules/.bin` to $PATH  
ENV PATH /usr/src/app/node_modules/.bin:$PATH  
  
# install and cache app dependencies  
COPY package.json /usr/src/app/package.json  
RUN npm install --silent  
RUN npm install react-scripts@1.1.1 -g --silent  
  
#Make port 3000 available to the world outside this container  
EXPOSE 3000  
# start app  
CMD ["npm", "start"]

