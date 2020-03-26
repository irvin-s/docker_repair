# seqtk container  
FROM phusion/baseimage  
MAINTAINER Dan Leehr <dan.leehr@duke.edu>  
  
# Install required libraries  
RUN apt-get update && apt-get install -y \  
seqtk  
  
CMD ["/usr/bin/seqtk"]  

