FROM ruby:2.0.0  
WORKDIR /usr/src/app  
COPY Gemfile* ./  
RUN bundle install  
COPY . .  
  
EXPOSE 3000  
CMD ["rails", "server", "-b", "0.0.0.0"]  

