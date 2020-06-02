FROM ruby:2.4.2-onbuild

MAINTAINER Matthew Bentley <matthew.t.bentley@gmail.com>

RUN apt-get update && apt-get install -y \
    postgresql-client vim \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN RAILS_ENV=production rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]
