FROM ruby:2.3.3-alpine  
  
RUN apk add --update openssl ca-certificates \  
&& update-ca-certificates \  
&& rm -rf /var/cache/apk/*  
  
COPY Gemfile Gemfile.lock /deps/  
RUN bundle install --gemfile=/deps/Gemfile  
  
WORKDIR /app  
COPY Rakefile .  
COPY src ./src  

