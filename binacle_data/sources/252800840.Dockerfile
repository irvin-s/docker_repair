FROM ruby:2.2-alpine  
  
RUN gem install sass  
WORKDIR /app  
  
ENTRYPOINT ["sass"]  

