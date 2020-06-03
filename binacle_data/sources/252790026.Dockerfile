FROM ruby:2.4-alpine  
  
RUN mkdir /webserver  
COPY webserver.rb /webserver  
  
WORKDIR /webserver  
CMD ["ruby", "webserver.rb"]  

