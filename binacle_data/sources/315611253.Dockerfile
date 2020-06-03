FROM node:alpine

# Create Orders API directory and copy source to it
RUN mkdir -p /usr/src/api
COPY . /usr/src/api

# Set working dir
WORKDIR /usr/src/api
RUN rm -rf node_modules

############ Install dependencies
RUN npm install

EXPOSE 3000
CMD [ "npm", "start" ]
