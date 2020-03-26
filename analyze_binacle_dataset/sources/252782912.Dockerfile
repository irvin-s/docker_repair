FROM ruby:alpine  
  
RUN mkdir -p /srv  
COPY provision.sh /provision.sh  
COPY Gemfile /srv/Gemfile  
COPY Gemfile.lock /srv/Gemfile.lock  
COPY main.rb /srv/main.rb  
RUN sh /provision.sh  
  
WORKDIR /srv  
  
CMD ["sh", "-c", "bundle exec ruby main.rb"]  

