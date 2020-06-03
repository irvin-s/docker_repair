FROM alpine:latest  
  
RUN apk add --update ruby ruby-bundler\  
ruby-io-console \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir /app  
WORKDIR /app  
ADD . /app  
  
RUN bundle install  
  
EXPOSE 4567  
CMD bundle exec rackup -p 4567 --host 0.0.0.0  

