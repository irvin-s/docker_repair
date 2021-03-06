# base image
FROM node:9.8.0

# set working directory
RUN mkdir /usr/src/shiptalent_admin
WORKDIR /usr/src/shiptalent_admin

# add `/usr/src/shiptalent_admin/node_modules/.bin` to $PATH
ENV PATH /usr/src/shiptalent_admin/node_modules/.bin:$PATH

# install and cache shiptalent_admin dependencies
COPY package.json /usr/src/shiptalent_admin/package.json
RUN npm install
# RUN npm install react-scripts@1.1.1 -g --silent
# RUN npm run build

# start app
CMD ["npm", "start"]
