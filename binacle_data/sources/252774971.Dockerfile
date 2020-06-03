# Build with docker build -t pry .  
# Fun with alias pry="docker run -it --rm pry"  
FROM ruby:2.3  
RUN gem install pry  
CMD ["/usr/local/bundle/bin/pry"]  

