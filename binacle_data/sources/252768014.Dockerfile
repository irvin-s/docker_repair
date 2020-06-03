FROM ruby:2.4-jessie  
  
COPY . /data  
WORKDIR /data  
  
ENV LANG C.UTF-8  
ENV LANGUAGE C.UTF-8  
ENV LC_ALL C.UTF-8  
RUN bundle  
  
ENTRYPOINT ["/data/bin/yawast"]  

