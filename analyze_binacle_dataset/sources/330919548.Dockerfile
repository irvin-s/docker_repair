FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https unzip
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y yarn nodejs
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update -qq && apt-get install -y google-chrome-stable
RUN wget -q https://chromedriver.storage.googleapis.com/2.35/chromedriver_linux64.zip -O /tmp/chromedriver_linux64.zip
RUN cd tmp && unzip chromedriver_linux64.zip && mv chromedriver /usr/local/bin
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
RUN yarn install
ADD . /app
CMD bundle exec rails s
