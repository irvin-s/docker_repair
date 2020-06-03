FROM alpine:3.6  
MAINTAINER Deniau Antonin <deniau.antonin@protonmail.com>  
  
RUN apk update && apk add \  
ruby ruby-dev build-base libffi-dev \  
&& echo 'gem: --no-document' > /etc/gemrc \  
&& rm -rf /var/cache/apk/*  
  
RUN gem install json aquatone  
  
ENTRYPOINT ["tail", "-f", "/dev/null"]  

