FROM ruby:2.4.1-alpine
RUN mkdir /app
WORKDIR /app
RUN gem install sinatra sinatra-contrib
COPY . .
EXPOSE 3000
CMD ruby server.rb