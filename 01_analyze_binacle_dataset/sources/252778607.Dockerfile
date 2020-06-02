FROM ruby:2.2.2  
MAINTAINER M. Lequeux--Gruninger <martin.lequeux.gruninger@gmail.com>  
  
RUN apt-get update -qq && apt-get install -y build-essential && apt-get  
RUN apt-get install -y postgresql  
RUN apt-get install -y libpq-dev  
RUN apt-get install -y nodejs npm nodejs-legacy  
  
ENV APP_HOME /app  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
  
ADD Gemfile* $APP_HOME/  
RUN bundle install  
  
ADD . $APP_HOME  
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace  

