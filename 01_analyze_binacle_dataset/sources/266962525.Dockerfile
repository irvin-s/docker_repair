FROM ubuntu:17.04

ENV WORKSPACE /gulp-starter-kit

WORKDIR ${WORKSPACE}
ADD . $WORKSPACE

ENV PATH $WORKSPACE/.yarn/bin:$PATH
ENV NVM_DIR /root/.nvm

RUN apt-get update && apt-get install -y \
  curl ruby-dev gcc \
  g++ git make bzip2 \
  python libpng-dev \
  libfontconfig1 libnotify-bin \
  && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install node \
  && nvm use node \
  && gem install sass \
  && npm config set user 0 \
  && npm config set unsafe-perm true \
  && npm config set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs/ \
  && npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/ \
  && npm config set registry https://registry.npm.taobao.org \
  && npm install babel-cli gulp-cli yarn -g \
  && yarn config set registry https://registry.npm.taobao.org \
  && yarn config set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs/ \
  && yarn config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/ \
  # && npm i
  && yarn

EXPOSE 8000 8080
