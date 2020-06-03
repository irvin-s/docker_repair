FROM m0sth8/base:latest  
  
# version 1.9.8 has a boring bug https://github.com/n1k0/casperjs/issues/1068  
ENV PHANTOMJS_VERSION 1.9.7  
ADD . /phantomjs  
RUN /phantomjs/install.sh && rm -rf /phantomjs  
  
ENTRYPOINT ["phantomjs"]

