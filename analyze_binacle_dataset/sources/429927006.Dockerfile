FROM library/rails:4.2.4
MAINTAINER Charles Darwin "darwin@senet.us"

RUN mkdir -p /usr/src/app
RUN bundle config --global frozen 1
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install

COPY . /usr/src/app

CMD ["bundle", "exec", "rake", "about"]
