FROM ruby:2.4.1-alpine  
  
ENV FAKES3_VERSION 0.2.4  
RUN set -ex \  
&& gem install fakes3 -v $FAKES3_VERSION \  
&& mkdir /buckets  
  
WORKDIR /buckets  
VOLUME /buckets  
  
CMD ["fakes3", "-r", "/buckets", "-p", "80"]  
EXPOSE 80  

