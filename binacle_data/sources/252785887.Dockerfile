FROM ruby:2.5-alpine  
  
RUN apk update && \  
apk add cmake gcc git libc-dev make && \  
ln -s /usr/bin/make /usr/bin/gmake  
  
ADD https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz /tmp/go.tar.gz  
RUN tar -C /usr/local -xzf /tmp/go.tar.gz  
ENV PATH $PATH:/usr/local/go/bin  
  
WORKDIR /srv  
  
COPY Gemfile .  
RUN bundle lock --add-platform ruby && \  
bundle lock --add-platform x86_64-linux  
RUN bundle install  
  
RUN apk add nodejs nodejs-npm  
COPY . .  
  
ENTRYPOINT ["bundle", "exec", "licensed"]  

