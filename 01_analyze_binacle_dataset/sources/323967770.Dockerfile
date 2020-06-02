FROM node:8.12.0-alpine

# Install app dependencies
COPY ./package.json /tmp/package.json
COPY ./package-lock.json /tmp/package-lock.json
RUN cd /tmp && npm install --production
RUN npm install -g pm2

# Create app directory
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/
WORKDIR /opt/app

# Bundle app source
COPY . /opt/app
COPY .eslintrc.js /opt/app
# Copy the standalone script



RUN npm run build
#RUN npm install http-server -g

#CMD [ "http-server", "dist" , "-p8081"]
CMD [ "pm2-docker", "start" , "startup.config.js"]
