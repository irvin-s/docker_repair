FROM ruby:2.3-slim  
  
MAINTAINER Dru Jensen <drujensen@gmail.com>  
  
# update package manager  
RUN apt-get update -qq  
  
# c libraries needed for most dev libraries  
RUN apt-get install -y build-essential git tmux  
  
# install latest nodejs packages  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
  
# install nodejs  
RUN apt-get install -y nodejs  
  
# for ssl  
RUN apt-get install -y libssl-dev  
  
# for postgres  
RUN apt-get install -y libpq-dev  
  
# for mysql  
RUN apt-get install -y libmysqlclient-dev  
  
# for nokogiri  
RUN apt-get install -y libxml2-dev libxslt1-dev  
  
# for capybara-webkit  
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb  
  
# for paperclip  
RUN apt-get install -y imagemagick  
  

