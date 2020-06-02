FROM ruby:2.3.1  
ADD Gemfile* /app/  
WORKDIR /app  
RUN gem install bundler && bundle install && mkdir /app/files  
  
EXPOSE 3030  
CMD ["fakes3", "server", "-p", "3030", "-a", "0.0.0.0", "-r", "/app/files"]  

