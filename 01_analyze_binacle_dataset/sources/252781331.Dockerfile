FROM ruby:2.1.3  
  
RUN mkdir /app  
WORKDIR /app  
  
ADD Gemfile /app/Gemfile  
ADD Gemfile.lock /app/Gemfile.lock  
  
  
# bundle update required for asset precompile  
RUN gem update --system  
RUN gem update bundler  
  
ENV BUNDLE_PATH /bundle  
RUN bundle install  
  
ADD . /app  
  
ENV PORT 80  
EXPOSE $PORT  
RUN RAILS_ENV=production bundle exec rake assets:precompile  
CMD bundle exec rails server -p $PORT

