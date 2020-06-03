FROM ruby:latest  
RUN gem install yard  
  
RUN mkdir /app  
WORKDIR /app  
VOLUME /app  
  
CMD yard server --reload  

