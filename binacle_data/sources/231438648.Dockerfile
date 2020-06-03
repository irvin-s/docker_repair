FROM node:5.11.1

# Create app directory
RUN mkdir -p /usr/src/app

# Establish where your CMD will execute
WORKDIR /usr/src/app

# Install app dependencies

# Note: If you were using a build server, you would do this outside of the
# container, along with tests, and copy the resulting node_modules directory into
# the container.  Since we are just using our local machines, and already have
# downloaded the dependencies, we copy them in the next step.

# COPY package.json /usr/src/app/
# RUN npm install

# Bundle app source into the container
COPY ./node_modules /usr/src/app/node_modules
COPY ./api /usr/src/app/api
COPY ./config /usr/src/app/config
COPY ./app.js /usr/src/app/

# Expose the port for the app
EXPOSE 10010

# Execute "node app.js"
CMD ["node", "app.js"]