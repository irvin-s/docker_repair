# Pull base image.
FROM dockerfile/nodejs

# Meta
MAINTAINER Sebastien Dubois <seb@dsebastien.net>

# Install Gulp
RUN npm install --global gulp jspm typescript@1.8.0-dev.20151118 http-server --no-optional

# Build the app
WORKDIR /opt/midnight_light/

# Note that we add package.json separately in order not to bust the cache
ADD package.json ./
RUN npm install --no-optional
RUN jspm install

# Note that we avoid unwanted files from being added by listing them in the .dockerignore file
ADD . ./
RUN gulp

# Run the app
#CMD ["/bin/ls", "-al"]
CMD ["http-server", "dist"]

# Expose ports
EXPOSE 8080
