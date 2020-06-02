FROM ubuntu  
  
RUN apt-get update && \  
apt-get install -y ruby  
  
RUN gem install sinatra  
RUN gem install sinatra-cross_origin  
  
COPY runner app.rb /  
  
RUN touch finished  
  
CMD ["bash", "runner"]  
  
EXPOSE 4567  

