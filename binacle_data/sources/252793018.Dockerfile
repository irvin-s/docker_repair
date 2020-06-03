FROM ruby:2.3  
MAINTAINER danillosl@gmail.com  
  
ENV DATABASE localhost:27017  
ENV USERNAME teste  
ENV PASSWORD teste  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
nodejs  
  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock ./  
RUN gem install bundler && bundle install --jobs 20 --retry 5  
  
COPY . ./  
  
EXPOSE 3000  
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

