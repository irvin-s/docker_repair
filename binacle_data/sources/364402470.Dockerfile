FROM digitallyseamless/nodejs-bower-grunt
MAINTAINER Igor Goltsov <igor@ecomgems.com>

# Install Node
# dependencies
ADD ./package.json /data/
RUN npm install

# Copy other
# project files
# into container
ADD ./server /data/server
ADD ./template /data/template
ADD ./Gruntfile.coffee /data/

# Remove file with
# dev environment
RUN rm /data/server/config/local.env.coffee


# Create folder that
# required for start
RUN mkdir /data/certs

# Expose ports
EXPOSE 8080
EXPOSE 8443

CMD ["grunt", "serve:dist"]
