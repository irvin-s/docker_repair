FROM node:6

# this method installs but requires a new shell to use it - not sure how to do that with docker
#RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn net-tools

RUN mkdir -p /code
WORKDIR /code
ADD ./package.json package.json

# set the location of yarn-cache so we can mount it as a volume in docker-compose to benefit from yarn's caching
# an to prevent having to rebuild this image
RUN yarn config set cache-folder /root/yarn-cache

# do all new package installs and updates from the yarn container with "docker-compose run yarn"
# we don't want to run yarn here because it makes the image larger than necessary and any change to package.json would rebuild the image
# to prevent this we mount yarn-cache as a docker-compose volume and use yarn.lock to take advantage of all that yarn has to offer
# this means you have to run "docker-compose run yarn" before running "docker-compose up" for the first time
# RUN yarn

ENV DOCKER 1
