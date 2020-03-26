FROM andrius/alpine-ruby:latest  
  
RUN apk add --update ruby-dev build-base libffi-dev nodejs  
  
WORKDIR /app  
  
RUN mkdir /app/data  
  
COPY Gemfile Gemfile  
COPY Guardfile Guardfile  
  
RUN bundle install  
  
VOLUME /app/data  
  
CMD bundle exec guard -p -l 1 --no-interactions  

