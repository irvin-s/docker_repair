FROM ruby:2.3  
RUN gem install -N sinatra  
  
COPY summon usr/local/bin/summon  
  
RUN mkdir /usr/local/lib/summon  
COPY summon-conjur usr/local/lib/summon  
  
WORKDIR /usr/src  
  
COPY test_app.rb test_app.rb  
COPY secrets.yml secrets.yml  
  
env PORT 80  
CMD [ "summon", "--provider", "summon-conjur", "ruby", "test_app.rb" ]  

