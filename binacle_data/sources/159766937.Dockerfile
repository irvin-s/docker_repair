FROM ruby:2.3

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install --deployment --without development test --jobs 4
ADD . /app

EXPOSE 5000
CMD ["bundle", "exec", "foreman", "start"]