FROM openjdk:8-jdk-alpine

RUN apk add --no-cache --update \
    bash \
    build-base \
    git \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    mariadb \
    mariadb-client \
    nodejs \
    pcre-dev \
    ruby \
    ruby-bundler \
    ruby-dev \
    ruby-io-console

RUN gem install nokogiri --version 1.6.7.2 --no-rdoc --no-ri -- --use-system-libraries

RUN mysql_install_db --user=mysql --rpm
