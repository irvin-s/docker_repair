FROM ruby:2.3  
MAINTAINER Thomas HUMMEL <thummel@codde.fr>  
ENV REFRESHED_AT 2017-04-06  
# throw errors if Gemfile has been modified since Gemfile.lock  
RUN bundle config --global frozen 1  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
  
RUN bundle install --without test development  
  
COPY . /usr/src/app  
  
COPY docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE 8080  
CMD ["rackup", "faye.ru", "-s", "thin", "-p", "8080", "-E", "production"]  

