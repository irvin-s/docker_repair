FROM ruby:2.1.2  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev  
# RUN mkdir /home/desire/professionnal/moonshots/uploading  
WORKDIR /home/desire/professionnal/moonshots/uploading  
ADD Gemfile /home/desire/professionnal/moonshots/uploading/Gemfile  
RUN bundle install  
ADD . src/  
CMD ["rails", "server"]  

