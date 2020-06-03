FROM ubuntu:12.04  
MAINTAINER David Bain <david@alteroo.com>  
  
RUN apt-get update -y && apt-get install gnuplot -y  
RUN apt-get install python-pip -y  
RUN pip install FunkLoad  
RUN pip install tcpwatch  
  
# Define mountable directories.  
VOLUME ["/tests"]  
VOLUME ["/test-output"]  
  
# Define working directory.  
WORKDIR /tests  
  
EXPOSE 8090  
EXPOSE 8007  

