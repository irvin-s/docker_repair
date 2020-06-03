FROM ruby:alpine  
  
RUN mkdir -p /srv  
COPY provision.sh /provision.sh  
COPY Gemfile /srv/Gemfile  
COPY Gemfile.lock /srv/Gemfile.lock  
COPY main.rb /srv/main.rb  
COPY run.sh /srv/run.sh  
COPY gem.rc /etc/gemrc  
RUN sh /provision.sh  
  
WORKDIR /srv  
  
CMD ["sh", "run.sh"]  

