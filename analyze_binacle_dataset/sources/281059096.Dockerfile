# Use the barebones version of Ruby?
FROM ruby:2.4.2-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER mmt <ccc@ccc.com>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets  ---is this needed?
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
# - git: in order to build gems from git repos
RUN apt-get update -qq && \
      apt-get install -qq -y  --fix-missing --no-install-recommends \
      libxml2 \
      libxml2-dev \
      git \
      build-essential \
      nodejs \
      libpq-dev \
      postgresql-client-9.4

# Set an environment variable to store where the app is installed to inside
# of the Docker image.

ENV PORT=80 HOST=0.0.0.0 INSTALL_PATH=/mmt

RUN mkdir -p $INSTALL_PATH

EXPOSE 80

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile.lock $INSTALL_PATH/
RUN bundle install
VOLUME /usr/local/bundle

# Copy in the application code from your work station at the current directory
# over to the working directory.

COPY . $INSTALL_PATH
# Provide dummy data to Rails so it can pre-compile assets.
#RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

#RUN bundle exec rake RAILS_ENV=development DATABASE_URL=185.203.118.36 db:create
#RUN bundle exec rake RAILS_ENV=development db:create
#RUN bundle exec rake RAILS_ENV=development db:migrate

# Expose a volume so that nginx will be able to read in assets in production.
#VOLUME ["$INSTALL_PATH/public"]

# The default command that gets ran will be to start the Unicorn server.
#CMD bundle exec unicorn -c config/unicorn.rb
