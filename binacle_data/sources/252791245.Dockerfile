FROM ruby:latest  
WORKDIR /app  
ADD . /app  
RUN bundle install  
ENTRYPOINT ["ruby", "app.rb"]  

