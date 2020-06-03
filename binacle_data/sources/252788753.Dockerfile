FROM debian:jessie  
  
MAINTAINER Alexander Harkness (bearbin)  
  
# Install the required components.  
RUN apt-get update && apt-get install -y git gcc g++ cmake make  

