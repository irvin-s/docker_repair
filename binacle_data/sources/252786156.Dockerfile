FROM ruby:2.2.5  
RUN gem install stasis haml bundler  
ADD stasis.sh /  
ENTRYPOINT ["/stasis.sh"]  

