FROM ruby:2.2-alpine  
  
RUN mkdir /app  
WORKDIR /app  
ADD . /app  
  
EXPOSE 80  
CMD ["/usr/local/bin/ruby", "/app/start.rb"]  
  

