FROM node:9-alpine@sha256:b9e63df2deb2b0a30cf67ec8f66ae433dacd2d99d16465bf98884baf8ce7c398

LABEL maintainer="epicallan.al@gmail.com"
# Copy package.json only to temp folder, install its dependencies,
# set workdir and copy the dependnecies there
RUN mkdir /src
# This way, dependnecies are cached without the need of cacheing all files.
COPY package.json /tmp/
RUN cd /tmp && npm install --production --silent
RUN cp -a /tmp/node_modules /src/

RUN npm install pm2 -g --silent

WORKDIR /src

# Copy the rest of the files to the container workdir
COPY . /src

ENV NODE_ENV production

EXPOSE 8080

CMD npm run start:docker
