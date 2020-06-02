FROM ruby:2.3.0  
WORKDIR /tmp  
COPY Gemfile Gemfile  
COPY Gemfile.lock Gemfile.lock  
RUN bundle install --without development test  
  
RUN mkdir /src  
ADD . /src  
WORKDIR /src  
  
EXPOSE 2000  
CMD ["ruby", "server.rb"]  

