FROM iron/ruby  
  
MAINTAINER Alan Platt <alan.platt@digital.hmrc.gov.uk>  
  
RUN curl 'http://unicornpoo.herokuapp.com/update/team4-turniptoes/complete'  
  
RUN apk --update add ruby-rdoc ruby-irb  
  
RUN gem install bundler  
  
ADD /unicorn /unicorn  
  
EXPOSE 8080  
WORKDIR /unicorn  
  
RUN bundle install  
  
CMD bundle exec rackup --port 8080 --host 0.0.0.0  
  

