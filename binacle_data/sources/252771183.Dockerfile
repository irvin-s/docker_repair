FROM ruby:2.1.6-onbuild  
ADD config.yml.sample /usr/src/app/config.yml  
VOLUME ["/usr/src/app/storage"]  
EXPOSE 9292  
CMD ["bundle", "exec", "unicorn", "-c", "unicorn.rb", "-E", "production"]  

