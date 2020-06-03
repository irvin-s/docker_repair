FROM blacksquare/ruby:2.3  
  
RUN mkdir -p /app/data  
WORKDIR /app  
  
RUN gem install fakes3 --no-rdoc --no-ri  
  
ENV PORT 4569  
EXPOSE ${PORT}  
  
CMD fakes3 -r /app/data -p $PORT  

