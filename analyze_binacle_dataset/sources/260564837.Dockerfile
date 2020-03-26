FROM ruby:2.3.1-slim

RUN apt-get update -qq && apt-get install -qq -y --no-install-recommends \
        curl build-essential git-core libfontconfig --fix-missing \
        && rm -rf /var/lib/apt/lists/* 

ENV INSTALL_PATH /opt
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile* ./
RUN  gem install bundler && bundle check || bundle install --jobs=4 --retry=3
ENV RAILS_ENV production

COPY . ./
# The Rails container doesn't need the renderer directory
RUN rm -rf renderer

EXPOSE 3000
CMD bundle exec rails server
