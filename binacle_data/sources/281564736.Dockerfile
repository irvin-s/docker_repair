FROM ruby

RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

ADD Gemfile Gemfile.lock /usr/src/app/
RUN bundle install

ADD . /usr/src/app/

CMD bin/start
