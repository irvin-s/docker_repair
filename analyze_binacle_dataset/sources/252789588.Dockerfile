FROM ruby:2.4.3  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs  
RUN mkdir /sample_app_reference  
RUN mkdir /sample_app_reference/config  
WORKDIR /sample_app_reference  
EXPOSE 3000  
COPY Gemfile /sample_app_reference/Gemfile  
COPY Gemfile.lock /sample_app_reference/Gemfile.lock  
RUN bundle install  
COPY . /sample_app_reference  
RUN bundle exec rake assets:precompile  
ENTRYPOINT ["/bin/bash","run.sh"]  

