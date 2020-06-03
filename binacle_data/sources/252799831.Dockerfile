FROM alpine  
RUN apk add \--no-cache ruby ruby-rdoc ruby-irb \  
&& gem install mustache  
  

