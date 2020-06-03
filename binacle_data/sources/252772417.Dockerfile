FROM ruby:2.3  
RUN apt-get update -qq && apt-get install -y \  
build-essential \  
libxml2-dev \  
libxslt1-dev \  
nodejs  
ENV APP_HOME /myapp  
ENV RAILS_ENV production  
RUN mkdir $APP_HOME  
WORKDIR $APP_HOME  
  
ADD Gemfile* $APP_HOME/  
RUN bundle install  
  
ADD . $APP_HOME  
  
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace  
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]  
EXPOSE 3000  

