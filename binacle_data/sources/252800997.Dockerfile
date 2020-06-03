FROM ruby:2.3.1  
MAINTAINER Daniel Pritchett <dpritchett@gmail.com>  
  
RUN gem install bundler && gem install rake && mkdir /app  
  
WORKDIR /app  
  
# precache vendorable bundle assets to speed up rebuilds  
COPY build/Gemfile* /app/  
RUN bundle install  
  
COPY Gemfile* /app/  
RUN bundle install  
  
COPY . /app  
  
CMD ["bundle exec lita"]  

