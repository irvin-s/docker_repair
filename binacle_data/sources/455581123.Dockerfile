FROM ruby:2.2

RUN gem install sinatra
RUN gem install activerecord
RUN gem install pg

ADD app.rb app.rb
ADD model.rb model.rb

CMD ruby app.rb
