FROM avatao/controller:ubuntu-16.04  
MAINTAINER Gergo Turcsanyi <gergo.turcsanyi@avatao.com>  
  
USER root  
  
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh  
  
COPY ./ /  
  
RUN adduser --disabled-password --gecos ',,,' \--uid 2001 controller  

