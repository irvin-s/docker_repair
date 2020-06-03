FROM ruby:2.3.4-slim  
  
RUN bundle config --global frozen 1  
  
WORKDIR /app  
  
COPY . /app/  
  
RUN bundle install  
  
RUN rake  
  
ENTRYPOINT ["/app/bin/ecsbatch", "start"]  

