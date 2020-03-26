FROM node:10.13.0

# install app
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app
RUN npm install
RUN npm rebuild node-sass

# run
CMD ["npm", "run", "styleguide:build"]
