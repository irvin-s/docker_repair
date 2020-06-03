FROM ruby:2.5.0-alpine  
  
ENV RAILS_ENV=production  
WORKDIR /app  
  
RUN apk add \--update --no-cache \  
build-base \  
git \  
less \  
libxml2-dev \  
libxslt-dev \  
postgresql-dev \  
tzdata && \  
bundle config build.nokogiri --use-system-libraries  
  
COPY Gemfile Gemfile.lock ./  
ARG BUNDLE_WITH=production  
RUN bundle install \--with=$BUNDLE_WITH  
  
COPY . ./  
  
CMD ["bin/rails", "s", "-b", "0.0.0.0"]  

