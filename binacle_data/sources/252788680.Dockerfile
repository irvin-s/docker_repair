FROM ruby:2.1.5  
RUN gem install less2sass  
  
VOLUME /work  
WORKDIR /work  
  
ENTRYPOINT ["less2sass"]

