FROM microsoft/aspnetcore:2.0  
MAINTAINER cowpanda<ynw506@gmail.com>  
  
COPY start_init /start_init  
RUN chmod 755 /start_init  
EXPOSE 80  
VOLUME ["/app"]  
WORKDIR /app  
  
CMD ["/start_init"]  
  

