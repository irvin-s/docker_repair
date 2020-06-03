FROM ruby:2.4.2-stretch  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -yf curl nmap python-dev python-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN pip install --upgrade setuptools  
RUN pip install sslyze sqlmap garmr  
  
ADD Gemfile* /gauntlt/  
WORKDIR /gauntlt  
RUN bundle install  
  

