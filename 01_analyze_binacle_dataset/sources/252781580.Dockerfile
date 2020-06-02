FROM ruby:2.3.0  
WORKDIR /tmp  
COPY Gemfile Gemfile  
COPY Gemfile.lock Gemfile.lock  
RUN bundle install --without development test  
  
RUN mkdir /src  
ADD . /src  
WORKDIR /src  
  
RUN RAILS_ENV=production bundle exec rake assets:precompile  
  
EXPOSE 3000  
CMD ["rails", "server", "-b0.0.0.0"]  

