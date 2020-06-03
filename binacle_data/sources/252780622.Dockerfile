FROM ruby:2.4.0  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install --assume-yes apt-utils  
  
RUN apt-get install -y build-essential libpq-dev  
  
# net tools  
RUN apt-get install -y net-tools  
  
# for nokogiri  
RUN apt-get install -y libxml2-dev libxslt1-dev  
  
# for mysql client  
RUN apt-get install -y mysql-client libmysqlclient-dev  
  
# for a JS runtime  
RUN apt-get install -y nodejs \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /tmp/app  
  
COPY Gemfile* ./  
  
RUN bundle install  

