FROM ruby:2.3  
RUN apt-get update  
  
# Install lftp for deployment  
RUN apt-get install lftp  
  
# Install addons  
RUN gem install jekyll -v 3.1.2  
RUN gem install redcarpet -v 3.3.4  
RUN gem install rouge -v 1.10.1  
RUN gem install jemoji -v 0.6.2  
  
# Working directory  
RUN mkdir /src  
WORKDIR /src  
  
# Create new user jekyll - to prevent user id issues  
RUN groupadd -g 1000 jekyll  
RUN useradd --home /src -u 1000 -g 1000 -M jekyll  

