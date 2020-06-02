FROM ruby:2.5.3

LABEL maintainer="dolan.stephen1@gmail.com"

# Get newest versions of Yarn and Node repos to install
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Add Google Chrome repo
RUN curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list

# Install the following apt based dependencies required to run application:
# - Build Essential for dev packages
# - PostgreSQL for gem 'pg'
# - NodeJS for JS runtime environment
# - Yarn for package installations and webpack compilation
# - OpenSSH Client for GitLab Capistrano SSH connections
# - Google Chrome for JavaScript testing
# - ImageMagick for ActiveStorage image variants
RUN apt-get update && apt-get install -y \
  build-essential \
  postgresql \
  nodejs \
  yarn \
  openssh-client \
  google-chrome-stable \
  imagemagick

# Configure the main working directory. This is the base directory used
# in any further RUN, COPY, and ENTRYPOINT commands.
RUN mkdir -p /app
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./
