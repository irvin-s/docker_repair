FROM m0sth8/base:latest  
  
ADD . /ruby  
RUN /ruby/install.sh && rm -rf /ruby

