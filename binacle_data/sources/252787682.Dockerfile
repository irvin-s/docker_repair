FROM ruby:2.2.2  
MAINTAINER Bruno Moyle <brunitto@gmail.com>  
RUN gem install sass  
WORKDIR /tmp  
ENTRYPOINT [ "sass", "--watch", "/src" ]  
  

