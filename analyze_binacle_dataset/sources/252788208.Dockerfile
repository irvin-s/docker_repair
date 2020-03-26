  
FROM ruby:2.3.0  
MAINTAINER Ryan Scott <ryankennethscott@gmail.com>  
  
# throw errors if Gemfile has been modified since Gemfile.lock  
RUN bundle config --global frozen 1  
  
RUN mkdir /app  
RUN mkdir /app/games  
WORKDIR /app  
COPY Gemfile /app/  
COPY Gemfile.lock /app/  
RUN bundle install  
  
COPY . /app  
  
EXPOSE 4567  
CMD ["ruby", "parse_game.rb"]  

