FROM ruby  
  
RUN gem install cucumber selenium-webdriver bundler  
# CMD ["ruby yesmail_app.rb"]  
CMD ["cucumber"]  

