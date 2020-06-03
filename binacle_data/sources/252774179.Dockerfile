FROM gliderlabs/alpine:3.3  
  
RUN apk update \  
&& apk add ruby python py-pip make build-base automake \  
autoconf linux-headers ruby-dev openssh \  
ca-certificates openssh curl \  
&& gem install bundler --no-rdoc --no-ri \  
&& pip install awscli --upgrade  
  
ENV PATH "$PATH:~/.local/bin:$PATH"  

