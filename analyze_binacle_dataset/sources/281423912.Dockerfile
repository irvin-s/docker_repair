FROM ubuntu:latest
MAINTAINER Nitin Reddy "redknitin@gmail.com"
EXPOSE 8000
RUN apt-get update
RUN apt-get install -y build-essential ruby-dev git mongodb rubygems rerun
#export PATH=$PATH:/opt/vagrant_ruby/bin/
RUN gem update --system
RUN gem install bundler
ADD ./ /code/
WORKDIR /code/
RUN bundle install
#bundle exec ruby app.rb
CMD rackup --host 0.0.0.0 -p 8000
