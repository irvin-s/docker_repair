FROM ruby:2.3.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install --without test
COPY . .

RUN rake assets:precompile

ENV RAILS_ENV production

ENV RAILS_SERVE_STATIC_FILES 1

EXPOSE 3000
CMD ["passenger", "start", "--port", "3000"]