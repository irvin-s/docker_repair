FROM starefossen/ruby-node  
  
RUN apt-get update  
RUN apt-get install -y openjdk-7-jre-headless  
  
RUN gem install s3_website  
RUN npm install cloudfront-invalidate-cli -g  
  
VOLUME ["/website", "/config"]  
  
WORKDIR /website  
  
CMD ["bash"]  

