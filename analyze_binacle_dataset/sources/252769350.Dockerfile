FROM ruby:2.2  
RUN gem install anemone  
  
COPY crawl.rb /data/crawl.rb  
  
ENTRYPOINT ["/data/crawl.rb"]  

