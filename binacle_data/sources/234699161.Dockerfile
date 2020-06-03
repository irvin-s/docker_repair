FROM ruby:2.5.0-alpine

# Pg
RUN apk --update --upgrade add postgresql-dev nodejs git build-base libffi-dev libgcc
RUN npm install -g bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc

ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# Bundle
COPY . /app
RUN gem update bundler && bundle install --jobs 4

EXPOSE 3000

# Run bower
WORKDIR $APP_ROOT/public
RUN bower install

WORKDIR $APP_ROOT