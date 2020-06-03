FROM dockerfile/ruby  
  
RUN gem install compass  
  
VOLUME ["/input", "/output"]  
  
WORKDIR /input  
  
ENTRYPOINT ["compass"]  
  
CMD ["--help"]  

