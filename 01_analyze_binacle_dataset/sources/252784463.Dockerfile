FROM fluent/fluentd:v0.14-onbuild  
USER fluent  
WORKDIR /home/fluent  
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH  
RUN gem install fluent-plugin-loggly  

