FROM ruby:latest  
  
# Install dashing and bundler  
RUN gem install dashing  
RUN gem install bundler  
  
# Install some other useful gems  
RUN gem install dashing-contrib  
RUN gem install travis-async-listener  
RUN gem install jira-ruby  
RUN gem install json  
RUN gem install therubyracer  
RUN gem install twitter  
  
CMD ["dashing", "start"]  

