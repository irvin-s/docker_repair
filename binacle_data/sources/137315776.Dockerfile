FROM ruby:2.5

ENV RAILS_ENV=production

# Install requirements for ruby gems.
RUN apt-get update && apt-get install -y aptitude
RUN aptitude install -y libssl-dev g++ libxml2 libxslt-dev libreadline-dev libicu-dev imagemagick libmagick-dev

# Install nodejs.
RUN aptitude install -y build-essential libssl-dev
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash
RUN aptitude install -y nodejs
RUN node --version
RUN npm i -g yarn

WORKDIR /app
RUN git clone https://github.com/fiedl/wingolfsplattform.git ./
RUN gem install bundler
RUN bundle install
ADD config/database.yml config/database.yml
ADD config/secrets.yml config/secrets.yml

RUN rake your_platform:install:node_modules || echo 'task not found'

ADD start start
CMD ["./start"]