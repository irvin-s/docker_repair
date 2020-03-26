FROM ruby:2.4  
LABEL maintainer "Dylan Pinn <dylan@arcadiandigital.com.au>"  
  
ENV DEBIAN_FRONTEND=noninteractive  
RUN apt-get update \  
&& apt-get install -y build-essential libpq-dev nodejs cmake libcurl3-dev \  
mysql-client mysql-server redis-server \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN gem install bundler -v 1.16.1  

