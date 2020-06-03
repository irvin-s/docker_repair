FROM ruby:2.4  
# Install Java for s3_website gem  
MAINTAINER Clif Reeder clifreeder@gmail.com  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -y \  
node openjdk-7-jre-headless \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/ \  
&& gem install bundler  
  
WORKDIR /tmp  
ADD Gemfile Gemfile  
ADD Gemfile.lock Gemfile.lock  
RUN bundle install  
  
COPY . /app  
WORKDIR /app  
  
CMD bundle exec rake deploy  

