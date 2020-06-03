FROM microsoft/aspnetcore-build:1.0-2.0  
MAINTAINER cowpanda<ynw506@gmail.com>  
LABEL platform="microsoft dotnetcore"  
  
COPY build_init /build_init  
RUN chmod 755 /build_init  
VOLUME ["/app"]  
WORKDIR /app  
  
CMD ["/build_init"]  
  

