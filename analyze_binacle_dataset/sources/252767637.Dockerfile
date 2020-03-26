FROM jruby:1.7-jdk  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ADD . /usr/src/app  
RUN bundle install --system  
  
ENTRYPOINT ["./bin/logstash"]  

