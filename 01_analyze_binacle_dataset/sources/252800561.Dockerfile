# The silver searcher based on the lightweight Alpine Linux  
FROM alpine:latest  
  
MAINTAINER donderom https://hub.docker.com/u/donderom  
  
RUN apk --update add the_silver_searcher  
  
WORKDIR /tmp  
  
ENTRYPOINT ["ag"]  
  
CMD ["--help"]  

