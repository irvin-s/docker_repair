FROM ruby:2.4  
  
LABEL maintainer "Dylan Pinn <dylan@arcadiandigital.com.au>"  
  
RUN apt-get update \  
&& apt-get install -y build-essential libpq-dev nodejs mysql-client cmake \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN gem install pronto pronto-rubocop  
  

