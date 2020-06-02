FROM node:5
MAINTAINER Nikos Kampitakis <kabitakis@gmail.com>

# Copy files to image
RUN mkdir /analytics
COPY . /analytics

# Install required modules
WORKDIR /analytics
RUN npm install
RUN ./node_modules/.bin/browserify -t reactify public/*.js -o public/js/bundle.js

# Run node
ENV NODE_ENV local
ENV GHTOKEN YOUR_GITHUB_TOKEN
CMD ["node", "github-analytics.js"]

EXPOSE 3000
