FROM ruby:2.3  
WORKDIR /usr/src/app  
COPY . /usr/src/app/  
  
RUN bundle install --no-deployment  
  
CMD [ "bundle", "exec", "rails", "s", "-b", "0.0.0.0" ]  
EXPOSE 3000  

