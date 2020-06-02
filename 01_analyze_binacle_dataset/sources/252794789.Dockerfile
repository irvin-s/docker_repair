FROM ruby  
  
# install compass (+sass)  
RUN gem update --system && gem install compass && gem install bootstrap-sass  
  
VOLUME ["/app"]  
WORKDIR /app  
  
ENTRYPOINT ["compass"]  
CMD ["help"]  

