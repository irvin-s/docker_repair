FROM debian:jessie  
  
RUN set -x \  
&& apt-get update -q \  
&& apt-get install -q -y python-pip \  
&& apt-get clean \  
&& pip install awscli  

