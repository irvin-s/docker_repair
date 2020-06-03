FROM node:10

# remove yarn provided by official image
RUN rm /usr/local/bin/yarn \
 && rm /usr/local/bin/yarnpkg \
 && rm -rf /opt/yarn

# install latest yarn
RUN apt-get update -q \
  && apt-get install apt-transport-https -y \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install yarn -y \
  && yarn --version

RUN yarn global add jscodeshift
