FROM rails:4.2.4  
MAINTAINER Julian Kaffke - julian@42nerds.com  
  
# Install imagemagick  
RUN apt-get update && \  
apt-get install -y imagemagick libmagickwand-dev --no-install-recommends && \  
rm -rf /var/lib/apt/lists/* && \  
apt-get clean  
  
# throw errors if Gemfile has been modified since Gemfile.lock  
RUN bundle config --global frozen 1  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
RUN bundle install  
  
COPY . /usr/src/app  
  
EXPOSE 3000  
ENV RAILS_ENV=production  
  
RUN bundle exec rake assets:precompile  
  
VOLUME /usr/src/app/public  
  
CMD ["rails", "server", "-b", "0.0.0.0"]

