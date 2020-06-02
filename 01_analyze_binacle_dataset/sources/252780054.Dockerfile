FROM ruby:alpine  
  
RUN mkdir /app  
WORKDIR /app  
  
COPY ./ /app  
  
ENTRYPOINT ["ruby", "run.rb"]  

