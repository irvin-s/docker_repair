FROM starefossen/ruby-node:latest  
MAINTAINER Dylan Ratcliffe <dylan.ratcliffe@puppet.com>  
  
RUN mkdir /app  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock /app/  
RUN bundle install -j 8 --without development  
  
COPY . /app  
  
EXPOSE 3030  
CMD ["bundle", "exec", "smashing", "start"]  

