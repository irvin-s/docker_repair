FROM ruby:2.4.1

MAINTAINER alaxallves@gmail.com

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
&& apt-get install -y nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn postgresql-client

WORKDIR /Falko-2017.2-BackEnd

ENV RAILS_ENV=production

ENV BUNDLE_PATH /bundle-cache

# Client ID provided by the GitHub Prod app
ENV CLIENT_ID=cbd5f91719282354f09b

# Client secret provided by the GitHub Prod app
ENV CLIENT_SECRET=634dd13c943b8196d4345334031c43d6d5a75fc8

COPY . /Falko-2017.2-BackEnd

COPY Gemfile /Falko-2017.2-BackEnd/Gemfile
COPY Gemfile.lock /Falko-2017.2-BackEnd/Gemfile.lock

EXPOSE 3000

ENTRYPOINT ["./start-prod.sh"]

