FROM eu.gcr.io/dnt-docker-registry-public/sherpa-www-base-image:1.0.0

# Copy static files
COPY static/. /sherpa/static/

# Copy webpack files
COPY webpack/. /sherpa/webpack/
WORKDIR /sherpa/webpack

# Install npm packages using yarn
RUN npm install node-sass
RUN yarn

# Build webpack project
RUN npm run build:prod

# Remove unused webpack files
WORKDIR /sherpa
RUN rm -rf /sherpa/webpack
