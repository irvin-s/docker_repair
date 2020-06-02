FROM iron/ruby  
MAINTAINER Tatiana Soukiassian binaryberry@gmail.com  
RUN apk --update add ruby-rdoc ruby-irb  
  
RUN gem install bundler  
  
ADD /unicorn /unicorn  
  
EXPOSE 8080  
WORKDIR /unicorn  
  
RUN bundle install  
  
RUN curl http://unicorn.herokuapp.com/update/team3-scuzzbuckets/complete  
  
CMD bundle exec rackup --port 8080 --host 0.0.0.0  

