FROM ruby:2.3.0  
WORKDIR /tmp  
COPY Gemfile Gemfile  
COPY Gemfile.lock Gemfile.lock  
RUN bundle install --without development test  
  
ADD . /src  
WORKDIR /src  
  
EXPOSE 4567  
CMD ["bundle", "exec", "./request-trail"]  

