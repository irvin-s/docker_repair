FROM ruby:2.4.0  
RUN apt-get update -qq  
RUN apt-get install -y nodejs libgmp3-dev  
  
ARG APP_ROOT=/source  
RUN mkdir $APP_ROOT  
WORKDIR $APP_ROOT  
  
COPY Gemfile* $APP_ROOT/  
RUN bundle install  
  
COPY . $APP_ROOT  
  
RUN ln -sfn /dev/stdout log/production.log  
RUN ln -sfn /dev/stdout log/staging.log  
  
CMD "./scripts/run_server.sh"  

