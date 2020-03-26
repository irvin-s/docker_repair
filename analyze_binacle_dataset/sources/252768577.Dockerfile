FROM ruby  
RUN gem install mailcatcher --no-rdoc --no-ri  
  
EXPOSE 1025  
EXPOSE 1080  
ENTRYPOINT ["mailcatcher"]  
CMD ["-f", "--ip=0.0.0.0"]  

