FROM ruby:2.3.3  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs  
RUN mkdir /app  
WORKDIR /app  
ADD Gemfile /app/Gemfile  
ADD Gemfile.lock /app/Gemfile.lock  
RUN bundle install  
ADD . /app  
  
ENV PORT=4000  
EXPOSE 4000  
RUN bin/rails db:migrate RAILS_ENV=development && \  
bin/rails db:seed RAILS_ENV=development  
  
ENTRYPOINT ["bundle", "exec"]  
CMD ["rails", "server", "-b", "0.0.0.0"]  

