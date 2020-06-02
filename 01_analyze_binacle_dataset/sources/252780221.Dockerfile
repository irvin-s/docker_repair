FROM ruby  
  
RUN gem install mdl  
  
ENTRYPOINT /usr/local/bundle/bin/mdl  

