FROM ruby:2.4  
ENV BUNDLER_VERSION=1.14.3  
RUN gem install bundler --version $BUNDLER_VERSION  
  
COPY entrypoint.sh /  
RUN chmod +x entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

