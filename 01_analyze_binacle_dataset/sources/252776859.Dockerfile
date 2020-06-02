FROM library/ruby:2.2.2  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
RUN bundle install  
COPY . /usr/src/app  
EXPOSE 4567  
CMD ["simple.rb"]  
ENTRYPOINT ["ruby"]  

