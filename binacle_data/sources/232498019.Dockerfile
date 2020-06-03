FROM rails:5.0

WORKDIR /opt
COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

CMD ["rails", "s", "-b", "0.0.0.0"]
