FROM ruby:2.3.3  
  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs  
  
RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no" > /root/.ssh/config  
RUN mkdir /app  
  
COPY install.sh /tmp/install.sh  
  
WORKDIR /app  
  
ENTRYPOINT "/tmp/install.sh"  

