FROM library/rails:4.2  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
EXPOSE 3000  
CMD bin/migrate_and_start  
  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
RUN bundle install  
  
COPY . /usr/src/app  

