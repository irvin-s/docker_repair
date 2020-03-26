FROM ruby:2.2.3  
MAINTAINER marko@codeship.com  
  
# Install apt based dependencies required to run Rails as  
# well as RubyGems. As the Ruby image itself is based on a  
# Debian image, we use apt-get to install those.  
RUN apt-get update -qq  
RUN apt-get install -y \  
build-essential \  
nodejs  
  
ENV app /app  
RUN mkdir $app  
WORKDIR $app  
  
ENV BUNDLE_PATH /bundle  
  
ADD . $app  
  
CMD rails s -b 0.0.0.0  

