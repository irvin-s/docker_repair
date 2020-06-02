FROM ruby:2.4.2

# シェルスクリプトとしてbashを利用
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# .ssh/ 配下をホストにコピー(id_rsa が必要であれば予めコピーしておくこと)
ADD .ssh /root/.ssh
RUN chown -R root:root /root/.ssh
RUN chmod -R 700 /root/.ssh

# 必要なライブラリインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn && \
  apt-get install -y nginx
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && apt-get install nodejs

# Nginx
ADD nginx.conf /etc/nginx/sites-available/app.conf
RUN rm -f /etc/nginx/sites-enabled/default && \
    ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/app.conf

# ワークディレクトリ設定
ENV ROOT_PATH /codeforelection_front
RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH
ADD Gemfile $ROOT_PATH/Gemfile
ADD Gemfile.lock $ROOT_PATH/Gemfile.lock
RUN bundle install
ADD . $ROOT_PATH
