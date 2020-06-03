FROM ruby:2.3.1

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1 <<< PRODUCTION ONLY

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY .irbrc /root
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

COPY . /usr/src/app
RUN bundle install

RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get update && apt-get install -y build-essential nodejs yarn --no-install-recommends
RUN alias node='nodejs'

EXPOSE 3000
EXPOSE 8080
CMD ["rails", "server", "-b", "0.0.0.0"]
