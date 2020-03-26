# base image
FROM node:8.9.3

# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ADD package.json .

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /usr/src/app/package.json
RUN npm install --silent
ADD ./ ./

ONBUILD EXPOSE 3001

# start app
CMD ["npm", "run", "dev"]