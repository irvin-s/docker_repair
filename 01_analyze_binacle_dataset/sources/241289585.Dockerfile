FROM ruby:2.2.4
MAINTAINER Joseph D. Marhee <joseph@marhee.me>

ADD app.rb app.rb
ADD Gemfile Gemfile
ADD views/index.erb views/index.erb

RUN bundle install

ENTRYPOINT ["ruby","app.rb","-o","0.0.0.0"]
