FROM ruby:2.4.1

MAINTAINER alaxallves@gmail.com

RUN apt-get update -qq \
    &&  apt-get install -y build-essential libpq-dev \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs \
    && apt-get update && apt-get install -y curl apt-transport-https wget \ 
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn postgresql-client

ENV BUNDLE_PATH /bundle-cache

WORKDIR /Falko-2017.2-BackEnd

COPY . /Falko-2017.2-BackEnd

CMD ["bundle", "exec", "rails", "s", "-p", "3000" "-b", "0.0.0.0"]
