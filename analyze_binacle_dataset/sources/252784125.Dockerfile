FROM ruby:2.4  
RUN apt-get update && \  
apt-get install -y nodejs mysql-client --no-install-recommends && \  
rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY Gemfile* ./  
RUN bundle install  
COPY . .  
  
COPY *.sh /usr/local/bin/  
RUN ln -s usr/local/bin/docker-entrypoint.sh / && \  
ln -s usr/local/bin/wait-for-it.sh /  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
EXPOSE 8080  
CMD ["biotooop"]  

