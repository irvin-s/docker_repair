FROM fluent/fluentd:v0.12.26  
MAINTAINER andrew.j.matheny@gmail.com  
  
USER fluent  
WORKDIR /home/fluent  
  
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH  
ENV GEM_PATH /home/fluent/.gem/ruby/2.3.0  
RUN gem install fluent-plugin-redis-store:0.1.1  
  
ADD run.sh /  
  
ENTRYPOINT ["/run.sh"]  

