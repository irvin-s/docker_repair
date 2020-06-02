FROM ruby  
  
WORKDIR /opt/slacktyping  
  
ADD Gemfile Gemfile.lock typing.rb /opt/slacktyping/  
  
RUN gem install bundler \  
&& bundle install  
  
CMD ["bundle", "exec", "ruby", "typing.rb"]  

