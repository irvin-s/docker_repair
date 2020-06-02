FROM ubuntu:trusty  
MAINTAINER defermat <defermat@defermat.net>  
  
# install golang and godocs  
RUN apt-get update && apt-get install -y golang golang-go.tools  
  
EXPOSE 6060  
CMD godoc -http=:6060  
  

