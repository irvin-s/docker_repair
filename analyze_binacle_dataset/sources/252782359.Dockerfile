FROM ruby  
RUN gem install deep_merge  
COPY yaml-merge.rb /usr/local/bin/yaml-merge  
ENTRYPOINT ["/usr/local/bin/yaml-merge"]  

