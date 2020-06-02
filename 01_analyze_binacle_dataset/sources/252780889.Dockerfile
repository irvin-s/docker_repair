FROM ruby:2.4.0  
MAINTAINER CorporateRewards  
  
RUN apt-get update && \  
apt-get install -y \  
node \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
mkdir -p /app  
  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock ./  
RUN bundle install --jobs 20 --retry 2  
  
COPY . ./  
  

