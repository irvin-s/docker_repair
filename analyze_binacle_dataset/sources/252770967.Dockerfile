FROM manageiq/ruby  
MAINTAINER agrare@redhat.com  
  
RUN yum -y install git  
RUN gem install bundler --conservative  
COPY Gemfile Gemfile  
RUN bundle install  
COPY . .  
ENTRYPOINT ["bundle", "exec", "ruby"]  
CMD ["worker.rb"]  

