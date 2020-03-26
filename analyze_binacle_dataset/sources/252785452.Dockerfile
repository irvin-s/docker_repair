FROM colstrom/ruby  
  
RUN gem install pry pry-doc  
  
ENTRYPOINT ["pry"]  

