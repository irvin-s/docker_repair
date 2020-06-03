FROM ruby:2.1-onbuild  
VOLUME ["/usr/src/app/config"]  
CMD ["./docker_clean.rb"]  

