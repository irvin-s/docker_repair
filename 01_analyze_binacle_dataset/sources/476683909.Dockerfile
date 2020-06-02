FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# Javascript runtime
RUN apt-get install -y nodejs

ADD dependencies /dependencies
WORKDIR dependencies

# PhantomJS for testing
RUN tar -xf phantomjs-*.tar.bz2 &&\
      mv phantomjs-*/bin/phantomjs /bin/ &&\
      rm -r phantom*

# Create application working directory
ENV APP_DIR /app
RUN mkdir $APP_DIR
WORKDIR $APP_DIR

# Add Gemfile and install gems
ADD Gemfile* $APP_DIR/
ENV BUNDLE_PATH /box/bundle
RUN bundle install
