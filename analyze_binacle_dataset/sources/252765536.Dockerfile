FROM ruby:2.3  
ENV workdir /usr/src/app  
RUN mkdir -p $workdir  
WORKDIR $workdir  
  
ADD Gemfile $workdir/Gemfile  
ADD Gemfile.lock $workdir/Gemfile.lock  
RUN bundle install  
  
ADD . $workdir/  
CMD ruby main.rb  

