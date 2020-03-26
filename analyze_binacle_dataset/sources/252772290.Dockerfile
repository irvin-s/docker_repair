FROM avatao/controller:ubuntu-14.04  
MAINTAINER Gergo Turcsanyi <gergo.turcsanyi@avatao.com>  
  
USER root  
  
RUN apt-get update \  
&& apt-get install -qy openjdk-7-jdk  
  
COPY ./ /  
  
RUN adduser --disabled-password --gecos ',,,' \--uid 2001 controller  

