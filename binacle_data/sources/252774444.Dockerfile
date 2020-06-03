FROM ruby:2.4.1-alpine  
  
ENV FAKES3_VERSION 0.2.4  
RUN addgroup -S fakes3 && adduser -S -G fakes3 fakes3 && \  
gem install fakes3 -v $FAKES3_VERSION && \  
mkdir /buckets && chown fakes3:fakes3 /buckets  
  
WORKDIR /buckets  
VOLUME /buckets  
  
USER fakes3  
CMD ["fakes3", "-r", "/buckets", "-p", "9000"]  
EXPOSE 9000  

