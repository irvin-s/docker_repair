# https://auth0.com/blog/ruby-on-rails-killer-workflow-with-docker-part-1/
# docker run --user $(id -u):$(id -g)

FROM starefossen/ruby-node:2-8-stretch
RUN apt-get update -qq && \
    apt-get install -y nano build-essential libpq-dev && \
    gem install bundler
RUN mkdir /project
COPY Gemfile Gemfile.lock /project/
WORKDIR /project
RUN bundle install
COPY . /project