FROM ruby:2.2.3
RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir /playground
WORKDIR /playground
ADD . /playground
ADD Gemfile /playground/Gemfile
ADD Gemfile.lock /playground/Gemfile.lock
RUN bundle install
RUN apt-get update && \
    apt-get -y install nginx && \
    apt-get -y install nodejs

RUN bundle exec jekyll build --destination /var/www/html/playground
CMD nginx -g 'daemon off;'
