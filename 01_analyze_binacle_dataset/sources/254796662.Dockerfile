FROM node:6.2
MAINTAINER Ivan Drondov

# Dependencies for canvas library
RUN apt-get install libcairo2-dev

WORKDIR /home/src
# For caching firstly copy only package.json
COPY ./package.json /home/src
RUN npm install

# Copy remaining code
COPY . /home/src
