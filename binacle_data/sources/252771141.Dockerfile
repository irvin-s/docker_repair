FROM ruby:2.2.2  
  
USER root  
  
# throw errors if Gemfile has been modified since Gemfile.lock  
RUN bundle config \--global frozen 1  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
RUN bundle install  
  
COPY . /usr/src/app  
  
CMD ["bundle", "exec", "ruby", "./main.rb"]  

