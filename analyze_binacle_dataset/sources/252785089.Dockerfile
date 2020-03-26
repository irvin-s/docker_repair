FROM ruby:2.4  
ENV BUNDLER_VERSION=1.14.3  
RUN gem install bundler --version $BUNDLER_VERSION  
  
COPY entrypoint.sh /  
COPY build.sh /project/build  
RUN chmod +x /entrypoint.sh  
RUN chmod +x /project/build  
ENTRYPOINT ["/entrypoint.sh"]

