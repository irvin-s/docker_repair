#
# Powder.js Dockerfile
#
# https://github.com/yamalight/generator-powder
#

# Pull base image
FROM dockerfile/nodejs

# install gulp
RUN npm install -g gulp bower

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
ADD docker/package.json /tmp/package.json
RUN cd /tmp && npm install --unsafe-perm
RUN mkdir -p /opt/app && cp -R /tmp/node_modules /opt/app

# use changes to bower.json to force Docker not to use the cache
# when we change our application's bower dependencies:
RUN mkdir -p /tmp/bower
ADD bower.json /tmp/bower/bower.json
RUN cd /tmp/bower && bower install --allow-root
RUN cp -R /tmp/bower/bower_components /opt/app

# copy bootstrap fonts
RUN mkdir -p /opt/app/public
RUN cp -R /tmp/bower/bower_components/bootstrap/fonts /opt/app/public

# Define working directory and bundle source
WORKDIR /opt/app
ADD . /opt/app
RUN gulp build

# Expose port 8080
EXPOSE 8080

# Define default command.
CMD ["node", "app.js"]
