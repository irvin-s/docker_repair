FROM ruby:2.2.2  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev  
  
WORKDIR /tmp  
COPY Gemfile Gemfile  
COPY Gemfile.lock Gemfile.lock  
RUN bundle install --without test  
  
RUN mkdir /src  
ADD . /src  
WORKDIR /src  
EXPOSE 3000  
ENV ORANGE stuff  
  
RUN bundle exec rake assets:precompile --trace  

