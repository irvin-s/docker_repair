FROM ruby:2.4.1-slim  
  
ADD Gemfile* /app/  
WORKDIR /app  
  
RUN bundle install -j2 --without development test  
ADD . /app  
  
EXPOSE 5000  
ENTRYPOINT ["rackup"]  
CMD ["--host", "0.0.0.0", "-p", "5000"]  

