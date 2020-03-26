FROM ruby:2.4  
RUN apt-get update && \  
apt-get install -y vim && \  
echo "syntax enable" > /root/.vimrc && \  
mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
ADD Gemfile Gemfile.lock /usr/src/app/  
  
RUN bundle install  
  
ADD . /usr/src/app/  
  
WORKDIR /data  
  
ENTRYPOINT ["ruby", "/usr/src/app/secret.rb"]  

