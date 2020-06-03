FROM alpine:3.3  
RUN apk --update add ruby  
RUN gem install --no-rdoc --no-ri resque json_pure  
  
EXPOSE 5678  
ENV redis redis.local:6379:0  
CMD resque-web -F -r $redis  

