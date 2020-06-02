FROM ruby:2.2.2-onbuild  
EXPOSE 80  
CMD ["bundle", "exec", "rackup", "-spuma", "-p80", "-o0.0.0.0"]

