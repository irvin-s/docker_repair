FROM ruby  
  
RUN gem install pe-razor-client --version 0.15.2  
RUN gem install json_pure  
  
ENTRYPOINT ["/usr/local/bundle/bin/razor"]  

