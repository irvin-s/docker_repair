###########################################################################
# Dockerfile to build node-app-template container image for development
# 
# The development container is identical to the production container except
# that it includes development and debugging tools and it mounts the host's
# project directory so that tests can automatically be run and the server
# restarted on code change.
# 
# Re-build the image and restart the container when package.json changes.
# When running the container:
#
# 1. Mount the /src/app volume to watch the edited source tree
# 2. Copy /tmp/app/node_modules to /src/app
#
# Note: Dockerfile instructions to mount a volume and copy the node_modules
# directory each execute in a new layer on top of the current image and
# commit the results. No matter which order we execute these instructions,
# we can't produce a mounted volume with node_modules dependencies
# populated at build time. We can either mount the volume and copy
# dependencies at run time; or we can forgo the mounted volume and build
# dependencies and source when we build the image, losing the ability to
# watch the source tree for changes and automatically run tests and reload
# the server.
###########################################################################

FROM thehackerati/node-app-template

# Install development and debugging tools
RUN npm install nodemon -g && \
    npm install grunt-cli -g

# Use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
ADD package.json /tmp/app/package.json
RUN cd /tmp/app && npm install

WORKDIR /opt/app

# Run CMD from the default ENTRYPOINT: /bin/sh -c /opt/app/run-dev-mode.sh
CMD ["/opt/app/run-dev-mode.sh"]
