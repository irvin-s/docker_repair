FROM agate/factual-docker-rvm-base  
  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN bash -l -c "rvm install 2.3.1"  
RUN bash -l -c "gem install bundler --no-ri --no-rdoc"  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

