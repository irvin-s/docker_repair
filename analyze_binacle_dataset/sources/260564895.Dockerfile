FROM node:6.9.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg |  apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" |  tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -qq -y yarn git-core libfontconfig --fix-missing --no-install-recommends

ENV INSTALL_PATH /opt
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY package.json yarn.lock ./
RUN yarn

ENV NODE_ENV production
ENV PATH $PATH:/opt/node_modules/.bin
ENV PORT 5000

COPY . ./

EXPOSE 5000
CMD yarn run start