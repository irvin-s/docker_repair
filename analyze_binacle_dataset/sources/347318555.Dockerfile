FROM node:10-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# By copying in package.json and running npm install BEFORE
# copying in the application code, the intermediate image this
# step generates can be reused as long as the package.json hasn't
# changed. Faster & less bandwidth used for builds!
COPY ./package.json /usr/src/app/package.json
COPY ./package-lock.json /usr/src/app/package-lock.json
RUN npm ci

# We _MUST_ copy the source code into the container so that
# the node process can start and the container can exist.
# The reason we _also_ mount the volume is so that changes
# on the host are immediately available in the container.
COPY . /usr/src/app/

# Start the giving node app
CMD [ "npm", "start" ]
