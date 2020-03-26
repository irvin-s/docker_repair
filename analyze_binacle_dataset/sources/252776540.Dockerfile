FROM ubuntu:14.04  
RUN apt-get update  
RUN apt-get install -y build-essential  
RUN apt-get install -y ruby ruby-dev  
RUN gem install bundler  
  
ADD . /base16api  
  
EXPOSE 80  
WORKDIR /base16api  
RUN bundle install  
  
CMD bundle exec ruby web.rb -p 80  

