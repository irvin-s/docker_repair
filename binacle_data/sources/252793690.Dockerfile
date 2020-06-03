FROM ruby:2.2  
RUN gem install webrick plist uuidtools  
  
ADD profile-service.rb /profile-service.rb  
RUN chmod +x profile-service.rb  
  
EXPOSE 8443  
CMD ["./profile-service.rb"]  
  

