FROM ruby:2.4.1

# Install basic tools and all of chromium's dependencies
RUN apt-get update && apt-get install -y \
  chromium \
  curl \
  git \
  libgconf2-4 \
  libgtk-3-0 \
  unzip

WORKDIR /

# Install latest chromium build
RUN git clone https://github.com/scheib/chromium-latest-linux.git
RUN cd chromium-latest-linux && ./update.sh 466398

# Copy our locally, hand-crafted artisan build of latest chromedriver
ADD selenium/chromedriver/build /chromedriver
ENV PATH=/chromedriver:$PATH

# Add our cucumber tests
RUN mkdir -p /test
WORKDIR /test

ADD Gemfile /test/Gemfile
ADD Gemfile.lock /test/Gemfile.lock

RUN bundle install

ADD features /test/features

ENTRYPOINT ["cucumber"]
