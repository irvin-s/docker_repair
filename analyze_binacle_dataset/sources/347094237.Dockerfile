############################################################################
# Dockerfile to build AWS deployment node-app-template container image
# 
###########################################################################

FROM node:argon

# Use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/
 
# From here, we load our application's code so the previous docker "layer"
# that was cached will be used if possible
WORKDIR /opt/app
ADD . /opt/app
 
# Define the default port. This can be overridden by the container manager
EXPOSE 3000
 
# Run app using CMD from the default ENTRYPOINT: /bin/sh -c npm start
CMD ["npm", "start"]
