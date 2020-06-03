FROM centurylink/ruby-base:2.1.2  
ADD . /var/app/docker-adapter  
WORKDIR /var/app/docker-adapter  
RUN bundle install  
  
CMD ["ruby", "/var/app/docker-adapter/docker-adapter.rb"]  

