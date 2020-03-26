FROM concordconsortium/ruby:1.9.3  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev  
  
# for a JS runtime  
RUN apt-get install -qq -y nodejs  
  
# install software-properties-common for add-apt-repository  
RUN apt-get install -qq -y software-properties-common  
  
# clean up ruby / gems / bundler  
RUN gem update --system  
RUN gem update bundler  
# get rid of old bundler version  
RUN gem cleanup bundler  
  
# install base version of rails  
RUN gem install rails -v 3.2.22  

