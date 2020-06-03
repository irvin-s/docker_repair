FROM ruby:2.2.3  
WORKDIR /app/user  
  
RUN apt-get update  
RUN apt-get install unzip  
  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get install -y nodejs  
  
ADD https://github.com/fastlane/boarding/archive/master.zip master.zip  
  
RUN unzip master.zip  
  
WORKDIR /app/user/boarding-master  
  
RUN bundle install  
  
EXPOSE 3000  
EXPOSE 80  
CMD bundle exec puma -C config/puma.rb  

