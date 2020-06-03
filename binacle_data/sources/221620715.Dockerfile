FROM ruby:2.1.8

RUN apt-get update
RUN apt-get install netcat -y

#set working dir for caching
WORKDIR /tmp

#cache bundle install
ADD Gemfile /tmp/Gemfile
ADD Gemfile.lock /tmp/Gemfile.lock
RUN bundle install

#set working dir
RUN mkdir /home/app
WORKDIR /home/app
COPY . /home/app

#start the test for api
CMD /home/app/start_test.sh