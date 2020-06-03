FROM ruby:2.4.0-slim

RUN mkdir /tictac
ADD . /tictac
WORKDIR /tictac

RUN bundle install
RUN bundle exec rake install

CMD [ "tictac" ]
